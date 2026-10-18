import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../data/subject_repository.dart';
import '../domain/subject.dart';

class SubjectController extends StateNotifier<AsyncValue<void>> {
  final SubjectRepository _repo;

  SubjectController(this._repo) : super(const AsyncValue.data(null));

  Future<void> createSubject({
    required String name,
    String? code,
    required int colorValue,
    required int iconCode,
    String? professor,
    String? classroom,
    int? credits,
    SubjectStatus status = SubjectStatus.enrolled,
    required String period,
    double passingGrade = 4.0,
    String? notes,
  }) async {
    state = const AsyncValue.loading();
    try {
      final now = DateTime.now();
      final subject = Subject(
        id: const Uuid().v4(),
        name: name.trim(),
        code: code?.trim().isEmpty == true ? null : code?.trim(),
        colorValue: colorValue,
        iconCode: iconCode,
        professor: professor?.trim().isEmpty == true ? null : professor?.trim(),
        classroom: classroom?.trim().isEmpty == true ? null : classroom?.trim(),
        credits: credits,
        status: status,
        period: period.trim(),
        passingGrade: passingGrade,
        notes: notes?.trim().isEmpty == true ? null : notes?.trim(),
        createdAt: now,
        updatedAt: now,
      );
      await _repo.upsertSubject(subject);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateSubject(Subject subject) async {
    state = const AsyncValue.loading();
    try {
      final updated = subject.copyWith(updatedAt: DateTime.now());
      await _repo.upsertSubject(updated);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteSubject(String id) async {
    state = const AsyncValue.loading();
    try {
      await _repo.softDeleteSubject(id);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> restoreSubject(String id) async {
    try {
      await _repo.restoreSubject(id);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final subjectControllerProvider =
    StateNotifierProvider<SubjectController, AsyncValue<void>>((ref) {
  final repo = ref.watch(subjectRepositoryProvider);
  return SubjectController(repo);
});
