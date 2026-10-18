import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../data/exam_repository.dart';
import '../domain/exam.dart';

class ExamController extends StateNotifier<AsyncValue<void>> {
  final ExamRepository _repo;

  ExamController(this._repo) : super(const AsyncValue.data(null));

  Future<void> createExam({
    required String subjectId,
    required ExamType type,
    required String title,
    required DateTime dateTime,
    int durationMinutes = 120,
    String? classroom,
    String? retakeOfExamId,
    ExamStatus status = ExamStatus.pending,
    bool remindersEnabled = true,
  }) async {
    state = const AsyncValue.loading();
    try {
      final now = DateTime.now();
      final exam = Exam(
        id: const Uuid().v4(),
        subjectId: subjectId,
        type: type,
        title: title.trim(),
        dateTime: dateTime,
        durationMinutes: durationMinutes,
        classroom: classroom?.trim().isEmpty == true ? null : classroom?.trim(),
        retakeOfExamId: retakeOfExamId,
        status: status,
        remindersEnabled: remindersEnabled,
        createdAt: now,
        updatedAt: now,
      );
      await _repo.upsertExam(exam);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateExam(Exam exam) async {
    state = const AsyncValue.loading();
    try {
      final updated = exam.copyWith(updatedAt: DateTime.now());
      await _repo.upsertExam(updated);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteExam(String id) async {
    state = const AsyncValue.loading();
    try {
      await _repo.softDeleteExam(id);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> restoreExam(String id) async {
    try {
      await _repo.restoreExam(id);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final examControllerProvider =
    StateNotifierProvider<ExamController, AsyncValue<void>>((ref) {
  final repo = ref.watch(examRepositoryProvider);
  return ExamController(repo);
});
