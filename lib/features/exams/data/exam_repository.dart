import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../domain/exam.dart';

abstract class ExamRepository {
  Stream<List<Exam>> watchExams({bool includeDeleted = false});
  Future<Exam?> getExamById(String id);
  Future<void> upsertExam(Exam exam);
  Future<void> softDeleteExam(String id);
  Future<void> restoreExam(String id);
}

class DriftExamRepository implements ExamRepository {
  final AppDatabase _db;
  DriftExamRepository(this._db);

  @override
  Stream<List<Exam>> watchExams({bool includeDeleted = false}) =>
      _db.watchExams(includeDeleted: includeDeleted);

  @override
  Future<Exam?> getExamById(String id) => _db.getExamById(id);

  @override
  Future<void> upsertExam(Exam exam) => _db.upsertExam(exam);

  @override
  Future<void> softDeleteExam(String id) => _db.softDeleteExam(id);

  @override
  Future<void> restoreExam(String id) => _db.restoreExam(id);
}

final examRepositoryProvider = Provider<ExamRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return DriftExamRepository(db);
});

final examsStreamProvider = StreamProvider<List<Exam>>((ref) {
  final repo = ref.watch(examRepositoryProvider);
  return repo.watchExams();
});
