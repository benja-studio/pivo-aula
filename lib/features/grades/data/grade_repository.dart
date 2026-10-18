import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../domain/grade_entry.dart';

abstract class GradeRepository {
  Stream<List<GradeEntry>> watchAllGrades();
  Stream<List<GradeEntry>> watchGradesForSubject(String subjectId);
  Future<void> upsertGrade(GradeEntry grade);
  Future<void> softDeleteGrade(String id);
  Future<void> restoreGrade(String id);
}

class DriftGradeRepository implements GradeRepository {
  final AppDatabase _db;
  DriftGradeRepository(this._db);

  @override
  Stream<List<GradeEntry>> watchAllGrades() => _db.watchAllGrades();

  @override
  Stream<List<GradeEntry>> watchGradesForSubject(String subjectId) =>
      _db.watchGradesForSubject(subjectId);

  @override
  Future<void> upsertGrade(GradeEntry grade) => _db.upsertGrade(grade);

  @override
  Future<void> softDeleteGrade(String id) => _db.softDeleteGrade(id);

  @override
  Future<void> restoreGrade(String id) => _db.restoreGrade(id);
}

final gradeRepositoryProvider = Provider<GradeRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return DriftGradeRepository(db);
});

final allGradesStreamProvider = StreamProvider<List<GradeEntry>>((ref) {
  final repo = ref.watch(gradeRepositoryProvider);
  return repo.watchAllGrades();
});

final subjectGradesStreamProvider = StreamProvider.family<List<GradeEntry>, String>((ref, subjectId) {
  final repo = ref.watch(gradeRepositoryProvider);
  return repo.watchGradesForSubject(subjectId);
});
