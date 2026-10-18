import 'dart:convert';
import 'dart:io';
import 'package:archive/archive.dart';
import 'package:crypto/crypto.dart';
import 'package:cryptography/cryptography.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:share_plus/share_plus.dart';
import '../database/app_database.dart';
import '../../features/profile/domain/student_profile.dart';
import '../../features/subjects/domain/subject.dart';
import '../../features/exams/domain/exam.dart';
import '../../features/topics/domain/topic.dart';
import '../../features/grades/domain/grade_entry.dart';

class BackupService {
  final AppDatabase _db;
  BackupService(this._db);

  /// Layer 1: Automatic local rotating backup (retains last 5).
  Future<void> performAutoBackup() async {
    try {
      final docs = await getApplicationDocumentsDirectory();
      final backupDir = Directory(p.join(docs.path, 'backups_local'));
      if (!backupDir.existsSync()) {
        backupDir.createSync(recursive: true);
      }

      final dbFile = File(p.join(docs.path, 'aula_local.sqlite'));
      if (!dbFile.existsSync()) return;

      // Flush committed WAL pages into the main database before copying it.
      await _db.customStatement('PRAGMA wal_checkpoint(FULL);');

      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final targetFile = File(p.join(backupDir.path, 'backup_$timestamp.sqlite'));
      await dbFile.copy(targetFile.path);

      // Clean up older backups retaining top 5
      final files = backupDir
          .listSync()
          .whereType<File>()
          .where((f) => f.path.endsWith('.sqlite'))
          .toList()
        ..sort((a, b) => b.lastModifiedSync().compareTo(a.lastModifiedSync()));

      if (files.length > 5) {
        for (int i = 5; i < files.length; i++) {
          try {
            files[i].deleteSync();
          } catch (_) {}
        }
      }
    } catch (_) {}
  }


  /// Returns recoverable on-device snapshots, newest first.
  Future<List<File>> listLocalBackups() async {
    final docs = await getApplicationDocumentsDirectory();
    final backupDir = Directory(p.join(docs.path, 'backups_local'));
    if (!await backupDir.exists()) return const <File>[];

    final backups = backupDir
        .listSync()
        .whereType<File>()
        .where((file) => p.basename(file.path).startsWith('backup_') &&
            file.path.toLowerCase().endsWith('.sqlite'))
        .toList()
      ..sort((a, b) => b.lastModifiedSync().compareTo(a.lastModifiedSync()));
    return backups;
  }

  /// Reads a backup's manifest without touching the current database.
  Future<bool> backupRequiresPassword(String filePath) async {
    final bytes = await File(filePath).readAsBytes();
    final archive = ZipDecoder().decodeBytes(bytes);
    final manifestFile = archive.findFile('manifest.json');
    if (manifestFile == null) {
      throw Exception('El archivo de respaldo no es válido (falta manifest).');
    }
    final manifest = jsonDecode(
      utf8.decode(manifestFile.content as List<int>),
    ) as Map<String, dynamic>;
    return manifest['isEncrypted'] as bool? ?? false;
  }

  /// Restores a local SQLite snapshot only after validating and reading it.
  Future<void> restoreLocalBackup(String filePath) async {
    final sourceFile = File(filePath);
    if (!await sourceFile.exists()) {
      throw Exception('La copia local ya no está disponible.');
    }

    final snapshotDb = AppDatabase(
      NativeDatabase.createInBackground(
        sourceFile,
        setup: (rawDb) => rawDb.execute('PRAGMA foreign_keys = ON;'),
      ),
    );
    try {
      if (!await snapshotDb.checkIntegrity()) {
        throw Exception('La copia local está dañada y no se puede restaurar.');
      }
      final profile = await snapshotDb.getProfile();
      final subjects = await snapshotDb.watchSubjects(includeDeleted: true).first;
      final exams = await snapshotDb.watchExams(includeDeleted: true).first;
      final topics = await snapshotDb.watchAllTopics().first;
      final grades = await snapshotDb.watchAllGrades().first;

      if (profile == null && subjects.isEmpty && exams.isEmpty &&
          topics.isEmpty && grades.isEmpty) {
        throw Exception('La copia local no contiene datos para recuperar.');
      }

      await _db.transaction(() async {
        await _db.clearAllData();
        if (profile != null) await _db.saveProfile(profile);
        for (final subject in subjects) {
          await _db.upsertSubject(subject);
        }
        for (final exam in exams) {
          await _db.upsertExam(exam);
        }
        for (final topic in topics) {
          await _db.upsertTopic(topic);
        }
        for (final grade in grades) {
          await _db.upsertGrade(grade);
        }
      });
    } finally {
      await snapshotDb.close();
    }
  }

  /// Layer 2 & 3: Export full data to versioned zip with manifest, SHA-256 and optional AES-GCM password.
  Future<String> exportBackup({String? password}) async {
    final profile = await _db.getProfile();
    final subjects = await _db.watchSubjects(includeDeleted: true).first;
    final exams = await _db.watchExams(includeDeleted: true).first;
    final topics = await _db.watchAllTopics().first;
    final grades = await _db.watchAllGrades().first;

    final dataMap = {
      'profile': profile?.toJson(),
      'subjects': subjects.map((s) => s.toJson()).toList(),
      'exams': exams.map((e) => e.toJson()).toList(),
      'topics': topics.map((t) => t.toJson()).toList(),
      'grades': grades.map((g) => g.toJson()).toList(),
    };

    final jsonString = jsonEncode(dataMap);
    final dataBytes = utf8.encode(jsonString);
    final checksum = sha256.convert(dataBytes).toString();

    final manifest = {
      'schemaVersion': 1,
      'appVersion': '1.0.0',
      'exportedAt': DateTime.now().toIso8601String(),
      'checksum': checksum,
      'isEncrypted': password != null && password.isNotEmpty,
    };

    final archive = Archive();
    archive.addFile(ArchiveFile('manifest.json', utf8.encode(jsonEncode(manifest)).length, utf8.encode(jsonEncode(manifest))));

    if (password != null && password.isNotEmpty) {
      // Encrypt dataBytes using AES-GCM
      final algorithm = AesGcm.with256bits();
      final secretKey = await algorithm.newSecretKeyFromBytes(
        sha256.convert(utf8.encode(password)).bytes,
      );
      final secretBox = await algorithm.encrypt(dataBytes, secretKey: secretKey);
      final encryptedBytes = secretBox.concatenation();
      archive.addFile(ArchiveFile('data.enc', encryptedBytes.length, encryptedBytes));
    } else {
      archive.addFile(ArchiveFile('data.json', dataBytes.length, dataBytes));
    }

    // Attach profile photo if exists
    if (profile?.photoPath != null) {
      final photoFile = File(profile!.photoPath!);
      if (photoFile.existsSync()) {
        final photoBytes = photoFile.readAsBytesSync();
        archive.addFile(ArchiveFile('photo${p.extension(photoFile.path)}', photoBytes.length, photoBytes));
      }
    }

    final zipData = ZipEncoder().encode(archive);
    if (zipData == null) throw Exception('No se pudo generar el archivo de respaldo');

    final tempDir = await getTemporaryDirectory();
    final outPath = p.join(
      tempDir.path,
      'aula_backup_${DateTime.now().year}_${DateTime.now().month}_${DateTime.now().day}.aula',
    );
    final outFile = File(outPath);
    await outFile.writeAsBytes(zipData);

    return outPath;
  }

  Future<void> shareBackupFile(String filePath) async {
    await Share.shareXFiles(
      [XFile(filePath)],
      subject: 'Respaldo de Aula - Vida Académica',
      text: 'Respaldo seguro y privado de mis datos universitarios.',
    );
  }

  /// Restores data from a backup zip file atomically in a transaction.
  Future<void> restoreBackup(String filePath, {String? password}) async {
    final bytes = await File(filePath).readAsBytes();
    final archive = ZipDecoder().decodeBytes(bytes);

    final manifestFile = archive.findFile('manifest.json');
    if (manifestFile == null) {
      throw Exception('El archivo de respaldo no es válido (falta manifest).');
    }

    final manifestJson = jsonDecode(utf8.decode(manifestFile.content as List<int>)) as Map<String, dynamic>;
    final isEncrypted = manifestJson['isEncrypted'] as bool? ?? false;
    final expectedChecksum = manifestJson['checksum'] as String;

    List<int> rawDataBytes;

    if (isEncrypted) {
      if (password == null || password.isEmpty) {
        throw Exception('Este respaldo está cifrado. Ingresá la contraseña para restaurar.');
      }
      final encFile = archive.findFile('data.enc');
      if (encFile == null) throw Exception('Falta el archivo cifrado de datos.');

      final algorithm = AesGcm.with256bits();
      final secretKey = await algorithm.newSecretKeyFromBytes(
        sha256.convert(utf8.encode(password)).bytes,
      );

      final encBytes = encFile.content as List<int>;
      // secretBox concatenation has 12 byte nonce + ciphertext + 16 byte MAC
      final secretBox = SecretBox.fromConcatenation(
        encBytes,
        nonceLength: algorithm.nonceLength,
        macLength: algorithm.macAlgorithm.macLength,
      );

      try {
        rawDataBytes = await algorithm.decrypt(secretBox, secretKey: secretKey);
      } catch (_) {
        throw Exception('Contraseña incorrecta. No se pudo descifrar el respaldo.');
      }
    } else {
      final dataFile = archive.findFile('data.json');
      if (dataFile == null) throw Exception('Falta data.json en el respaldo.');
      rawDataBytes = dataFile.content as List<int>;
    }

    // Verify Checksum
    final actualChecksum = sha256.convert(rawDataBytes).toString();
    if (actualChecksum != expectedChecksum) {
      throw Exception('Error de integridad: el respaldo fue modificado o está dañado.');
    }

    final data = jsonDecode(utf8.decode(rawDataBytes)) as Map<String, dynamic>;

    // Decode and validate every record before touching the current database.
    var restoredProfile = data['profile'] == null
        ? null
        : StudentProfile.fromJson(data['profile'] as Map<String, dynamic>);
    final restoredSubjects = (data['subjects'] as List? ?? const [])
        .map((item) => Subject.fromJson(item as Map<String, dynamic>))
        .toList(growable: false);
    final restoredExams = (data['exams'] as List? ?? const [])
        .map((item) => Exam.fromJson(item as Map<String, dynamic>))
        .toList(growable: false);
    final restoredTopics = (data['topics'] as List? ?? const [])
        .map((item) => Topic.fromJson(item as Map<String, dynamic>))
        .toList(growable: false);
    final restoredGrades = (data['grades'] as List? ?? const [])
        .map((item) => GradeEntry.fromJson(item as Map<String, dynamic>))
        .toList(growable: false);

    // Save any photo first; redirect the restored profile to the new path.
    final photoArchive = archive.files.where((f) => f.name.startsWith('photo')).firstOrNull;
    if (photoArchive != null) {
      final docs = await getApplicationDocumentsDirectory();
      final photoTarget = File(p.join(docs.path, 'restored_${photoArchive.name}'));
      await photoTarget.writeAsBytes(photoArchive.content as List<int>);
      if (restoredProfile != null) {
        restoredProfile = restoredProfile.copyWith(photoPath: photoTarget.path);
      }
    }

    await _db.transaction(() async {
      await _db.clearAllData();
      if (restoredProfile != null) await _db.saveProfile(restoredProfile);
      for (final subject in restoredSubjects) {
        await _db.upsertSubject(subject);
      }
      for (final exam in restoredExams) {
        await _db.upsertExam(exam);
      }
      for (final topic in restoredTopics) {
        await _db.upsertTopic(topic);
      }
      for (final grade in restoredGrades) {
        await _db.upsertGrade(grade);
      }
    });
  }
}
