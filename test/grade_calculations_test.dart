import 'package:flutter_test/flutter_test.dart';
import 'package:pivo_aula/features/grades/domain/grade_entry.dart';
import 'package:pivo_aula/features/grades/presentation/grade_controller.dart';

void main() {
  group('GradeCalculations Tests', () {
    test('calculateAverage with equal weights', () {
      final grades = [
        GradeEntry(
          id: '1',
          subjectId: 'sub1',
          title: 'Parcial 1',
          value: 8.0,
          weight: 1.0,
          date: DateTime.now(),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        GradeEntry(
          id: '2',
          subjectId: 'sub1',
          title: 'Parcial 2',
          value: 6.0,
          weight: 1.0,
          date: DateTime.now(),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      ];

      final avg = GradeCalculations.calculateAverage(grades);
      expect(avg, 7.0);
    });

    test('calculateAverage with weighted values', () {
      final grades = [
        GradeEntry(
          id: '1',
          subjectId: 'sub1',
          title: 'Parcial',
          value: 10.0,
          weight: 0.7, // 70%
          date: DateTime.now(),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        GradeEntry(
          id: '2',
          subjectId: 'sub1',
          title: 'TP',
          value: 5.0,
          weight: 0.3, // 30%
          date: DateTime.now(),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      ];

      final avg = GradeCalculations.calculateAverage(grades);
      // 10*0.7 + 5*0.3 = 7.0 + 1.5 = 8.5
      expect(avg, closeTo(8.5, 0.001));
    });

    test('calculateRequiredGrade for target average', () {
      // Current: got a 6 on exam 1 with weight 1.0
      // Target: 8.0 overall average with 1 exam remaining (weight 1.0)
      // Equation: (6*1 + X*1) / 2 = 8 => 6 + X = 16 => X = 10
      final grades = [
        GradeEntry(
          id: '1',
          subjectId: 'sub1',
          title: 'Parcial 1',
          value: 6.0,
          weight: 1.0,
          date: DateTime.now(),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      ];

      final needed = GradeCalculations.calculateRequiredGrade(
        currentGrades: grades,
        targetAverage: 8.0,
        remainingWeight: 1.0,
      );

      expect(needed, closeTo(10.0, 0.001));
    });

    test('calculateRequiredGrade impossible target returns > 10', () {
      final grades = [
        GradeEntry(
          id: '1',
          subjectId: 'sub1',
          title: 'Parcial 1',
          value: 2.0,
          weight: 1.0,
          date: DateTime.now(),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      ];

      final needed = GradeCalculations.calculateRequiredGrade(
        currentGrades: grades,
        targetAverage: 9.0,
        remainingWeight: 1.0,
      );

      // (2 + X) / 2 = 9 => X = 16 (impossible on a 10 scale)
      expect(needed, closeTo(16.0, 0.001));
      expect(needed! > 10.0, isTrue);
    });
  });
}
