import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../data/grade_repository.dart';
import '../domain/grade_entry.dart';

class GradeController extends StateNotifier<AsyncValue<void>> {
  final GradeRepository _repo;

  GradeController(this._repo) : super(const AsyncValue.data(null));

  Future<void> createGrade({
    String? examId,
    required String subjectId,
    required String title,
    required double value,
    double weight = 1.0,
    GradeKind kind = GradeKind.exam,
    bool isRetake = false,
    bool replacesOriginal = true,
    required DateTime date,
  }) async {
    state = const AsyncValue.loading();
    try {
      final now = DateTime.now();
      final grade = GradeEntry(
        id: const Uuid().v4(),
        examId: examId,
        subjectId: subjectId,
        title: title.trim(),
        value: value,
        weight: weight,
        kind: kind,
        isRetake: isRetake,
        replacesOriginal: replacesOriginal,
        date: date,
        createdAt: now,
        updatedAt: now,
      );
      await _repo.upsertGrade(grade);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateGrade(GradeEntry grade) async {
    state = const AsyncValue.loading();
    try {
      final updated = grade.copyWith(updatedAt: DateTime.now());
      await _repo.upsertGrade(updated);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteGrade(String id) async {
    state = const AsyncValue.loading();
    try {
      await _repo.softDeleteGrade(id);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> restoreGrade(String id) async {
    try {
      await _repo.restoreGrade(id);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final gradeControllerProvider =
    StateNotifierProvider<GradeController, AsyncValue<void>>((ref) {
  final repo = ref.watch(gradeRepositoryProvider);
  return GradeController(repo);
});

class GradeCalculations {
  GradeCalculations._();

  /// Calculates weighted average of grades.
  /// If [effectiveGrades] is true, accounts for retakes replacing originals.
  static double calculateAverage(List<GradeEntry> grades) {
    if (grades.isEmpty) return 0.0;

    double sum = 0.0;
    double totalWeight = 0.0;

    for (final g in grades) {
      sum += g.value * g.weight;
      totalWeight += g.weight;
    }

    if (totalWeight == 0) return 0.0;
    return sum / totalWeight;
  }

  /// Calculates what grade is needed in remaining exam/weight to reach target.
  /// Formula: target = (currentWeightedSum + requiredGrade * remainingWeight) / (currentWeight + remainingWeight)
  /// => requiredGrade = (target * (currentWeight + remainingWeight) - currentWeightedSum) / remainingWeight
  static double? calculateRequiredGrade({
    required List<GradeEntry> currentGrades,
    required double targetAverage,
    required double remainingWeight,
  }) {
    if (remainingWeight <= 0) return null;

    double currentWeightedSum = 0.0;
    double currentWeight = 0.0;

    for (final g in currentGrades) {
      currentWeightedSum += g.value * g.weight;
      currentWeight += g.weight;
    }

    final totalTargetSum = targetAverage * (currentWeight + remainingWeight);
    final needed = (totalTargetSum - currentWeightedSum) / remainingWeight;
    return needed;
  }
}
