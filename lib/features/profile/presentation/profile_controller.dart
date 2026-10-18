import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';
import '../data/profile_repository.dart';
import '../domain/student_profile.dart';

class ProfileController extends StateNotifier<AsyncValue<StudentProfile?>> {
  final ProfileRepository _repo;

  ProfileController(this._repo) : super(const AsyncValue.loading()) {
    _init();
  }

  void _init() {
    _repo.watchProfile().listen(
      (profile) {
        state = AsyncValue.data(profile);
      },
      onError: (err, stack) {
        state = AsyncValue.error(err, stack);
      },
    );
  }

  Future<String?> pickAndSaveImage(ImageSource source) async {
    try {
      final picker = ImagePicker();
      final picked = await picker.pickImage(
        source: source,
        maxWidth: 600,
        maxHeight: 600,
        imageQuality: 85,
      );
      if (picked == null) return null;

      final docsDir = await getApplicationDocumentsDirectory();
      final ext = p.extension(picked.path);
      final filename = 'profile_${DateTime.now().millisecondsSinceEpoch}$ext';
      final savedFile = File(p.join(docsDir.path, filename));

      await File(picked.path).copy(savedFile.path);
      return savedFile.path;
    } catch (_) {
      return null;
    }
  }

  Future<void> saveProfile({
    required String fullName,
    required String career,
    required String university,
    required String currentYear,
    required String currentPeriod,
    String? studentId,
    String? email,
    String? photoPath,
    String themeMode = 'system',
    int accentColorValue = 0xFF3B5BFD,
    String gradeScale = '1-10',
    double passingGrade = 4.0,
    bool remindersEnabled = true,
    bool biometricEnabled = false,
    bool reduceMotion = false,
  }) async {
    final current = state.value;
    final now = DateTime.now();

    final profile = StudentProfile(
      id: current?.id ?? const Uuid().v4(),
      fullName: fullName.trim(),
      career: career.trim(),
      university: university.trim(),
      currentYear: currentYear.trim(),
      currentPeriod: currentPeriod.trim(),
      studentId: studentId?.trim(),
      email: email?.trim(),
      photoPath: photoPath ?? current?.photoPath,
      themeMode: themeMode,
      accentColorValue: accentColorValue,
      gradeScale: gradeScale,
      passingGrade: passingGrade,
      remindersEnabled: remindersEnabled,
      biometricEnabled: biometricEnabled,
      reduceMotion: reduceMotion,
      createdAt: current?.createdAt ?? now,
      updatedAt: now,
    );

    await _repo.saveProfile(profile);
  }

  Future<void> updateAppearance({
    String? themeMode,
    int? accentColorValue,
    bool? reduceMotion,
  }) async {
    final current = state.value;
    if (current == null) return;
    final updated = current.copyWith(
      themeMode: themeMode,
      accentColorValue: accentColorValue,
      reduceMotion: reduceMotion,
      updatedAt: DateTime.now(),
    );
    await _repo.saveProfile(updated);
  }
}

final profileControllerProvider =
    StateNotifierProvider<ProfileController, AsyncValue<StudentProfile?>>((ref) {
  final repo = ref.watch(profileRepositoryProvider);
  return ProfileController(repo);
});
