import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../domain/subject.dart';

abstract class SubjectRepository {
  Stream<List<Subject>> watchSubjects({bool includeDeleted = false});
  Future<Subject?> getSubjectById(String id);
  Future<void> upsertSubject(Subject subject);
  Future<void> softDeleteSubject(String id);
  Future<void> restoreSubject(String id);
}

class DriftSubjectRepository implements SubjectRepository {
  final AppDatabase _db;
  DriftSubjectRepository(this._db);

  @override
  Stream<List<Subject>> watchSubjects({bool includeDeleted = false}) =>
      _db.watchSubjects(includeDeleted: includeDeleted);

  @override
  Future<Subject?> getSubjectById(String id) => _db.getSubjectById(id);

  @override
  Future<void> upsertSubject(Subject subject) => _db.upsertSubject(subject);

  @override
  Future<void> softDeleteSubject(String id) => _db.softDeleteSubject(id);

  @override
  Future<void> restoreSubject(String id) => _db.restoreSubject(id);
}

final subjectRepositoryProvider = Provider<SubjectRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return DriftSubjectRepository(db);
});

final subjectsStreamProvider = StreamProvider<List<Subject>>((ref) {
  final repo = ref.watch(subjectRepositoryProvider);
  return repo.watchSubjects();
});
