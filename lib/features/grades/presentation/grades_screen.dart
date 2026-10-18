import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../core/design_system/app_radius.dart';
import '../../../core/design_system/app_spacing.dart';
import '../../../core/design_system/app_typography.dart';
import '../../../core/design_system/components/app_card.dart';
import '../../../core/design_system/components/empty_state.dart';
import '../../../core/design_system/components/pressable_scale.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/l10n/app_strings.dart';
import '../../subjects/data/subject_repository.dart';
import '../../profile/data/profile_repository.dart';
import '../data/grade_repository.dart';
import '../domain/grade_entry.dart';
import 'grade_controller.dart';
import 'grade_calculator_sheet.dart';
import 'upsert_grade_sheet.dart';

class GradesScreen extends ConsumerWidget {
  const GradesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final profileAsync = ref.watch(profileStreamProvider);
    final passingThreshold = profileAsync.value?.passingGrade ?? 4.0;

    final allGradesAsync = ref.watch(allGradesStreamProvider);
    final subjectsAsync = ref.watch(subjectsStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.gradesTitle, style: AppTypography.titleLarge),
        actions: [
          IconButton(
            icon: const Icon(Icons.calculate_outlined),
            tooltip: 'Calculadora de nota',
            onPressed: () => GradeCalculatorSheet.show(context),
          ),
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.md),
            child: PressableScale(
              onTap: () => UpsertGradeSheet.show(context),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: 6),
                decoration: ShapeDecoration(
                  color: theme.colorScheme.primary,
                  shape: AppRadius.continuousSm(),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.add_rounded, size: 18, color: Colors.white),
                    SizedBox(width: 4),
                    Text(
                      'Nueva',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: allGradesAsync.when(
        data: (grades) {
          final subjects = subjectsAsync.value ?? [];

          if (grades.isEmpty) {
            return EmptyState(
              icon: Icons.grade_rounded,
              title: 'Sin calificaciones cargadas',
              description: 'Registrá tus notas para ver promedios automáticos, evolución y estadísticas.',
              actionLabel: 'Registrar primera nota',
              onAction: () => UpsertGradeSheet.show(context),
            );
          }

          final overallAverage = GradeCalculations.calculateAverage(grades);
          final isPassing = overallAverage >= passingThreshold;

          // Group grades chronologically for the evolution line chart
          final sortedGrades = List<GradeEntry>.from(grades)
            ..sort((a, b) => a.date.compareTo(b.date));

          final spots = <FlSpot>[];
          for (int i = 0; i < sortedGrades.length; i++) {
            spots.add(FlSpot(i.toDouble(), sortedGrades[i].value));
          }

          return ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            physics: const BouncingScrollPhysics(),
            children: [
              // Overall Average Highlight Card
              AppCard(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppStrings.overallAverage, style: AppTypography.titleMedium),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          isPassing ? 'Rendimiento general aprobado' : 'Por debajo del umbral mínimo',
                          style: AppTypography.caption.copyWith(
                            color: isPassing ? Colors.green : Colors.red,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          '${grades.length} evaluaciones registradas',
                          style: AppTypography.caption.copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: ShapeDecoration(
                        color: isPassing
                            ? Colors.green.withValues(alpha: isDark ? 0.2 : 0.1)
                            : Colors.red.withValues(alpha: isDark ? 0.2 : 0.1),
                        shape: AppRadius.continuousMd(),
                      ),
                      child: Text(
                        AppFormatters.grade(overallAverage),
                        style: AppTypography.display.copyWith(
                          color: isPassing ? Colors.green : Colors.red,
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // Evolution Chart Card
              if (spots.length >= 2) ...[
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Evolución de notas', style: AppTypography.titleSmall),
                          Text('Últimas notas', style: AppTypography.caption.copyWith(color: Colors.grey)),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      SizedBox(
                        height: 160,
                        child: LineChart(
                          LineChartData(
                            gridData: const FlGridData(show: false),
                            titlesData: const FlTitlesData(
                              leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                              rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                              bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            ),
                            borderData: FlBorderData(show: false),
                            minY: 0,
                            maxY: 10,
                            lineBarsData: [
                              LineChartBarData(
                                spots: spots,
                                isCurved: true,
                                color: theme.colorScheme.primary,
                                barWidth: 3,
                                isStrokeCapRound: true,
                                dotData: const FlDotData(show: true),
                                belowBarData: BarAreaData(
                                  show: true,
                                  color: theme.colorScheme.primary.withValues(alpha: 0.15),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
              ],

              // Grades by Subject
              Text('Notas por materia', style: AppTypography.titleMedium),
              const SizedBox(height: AppSpacing.sm),
              ...subjects.map((sub) {
                final subGrades = grades.where((g) => g.subjectId == sub.id).toList();
                if (subGrades.isEmpty) return const SizedBox.shrink();

                final subAvg = GradeCalculations.calculateAverage(subGrades);
                final subColor = Color(sub.colorValue);

                return Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.md),
                  child: AppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(color: subColor, shape: BoxShape.circle),
                            ),
                            const SizedBox(width: AppSpacing.sm),
                            Expanded(
                              child: Text(sub.name, style: AppTypography.titleSmall),
                            ),
                            Text(
                              'Prom: ${AppFormatters.grade(subAvg)}',
                              style: AppTypography.titleSmall.copyWith(
                                color: subAvg >= sub.passingGrade ? Colors.green : Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Divider(
                          height: 1,
                          color: isDark ? const Color(0xFF262A32) : const Color(0xFFF3F4F6),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        ...subGrades.map((g) {
                          return Dismissible(
                            key: Key(g.id),
                            direction: DismissDirection.endToStart,
                            background: Container(
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.only(right: 16),
                              color: Colors.red,
                              child: const Icon(Icons.delete_outline, color: Colors.white),
                            ),
                            onDismissed: (_) {
                              ref.read(gradeControllerProvider.notifier).deleteGrade(g.id);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Se eliminó ${g.title}'),
                                  action: SnackBarAction(
                                    label: AppStrings.undo,
                                    onPressed: () {
                                      ref.read(gradeControllerProvider.notifier).restoreGrade(g.id);
                                    },
                                  ),
                                ),
                              );
                            },
                            child: ListTile(
                              dense: true,
                              contentPadding: EdgeInsets.zero,
                              onTap: () => UpsertGradeSheet.show(context, gradeToEdit: g),
                              title: Text(g.title, style: AppTypography.bodyMedium),
                              subtitle: Text(
                                '${g.kind.label} · Peso ${g.weight.toStringAsFixed(0)} · ${AppFormatters.date(g.date)}',
                                style: AppTypography.caption.copyWith(color: Colors.grey),
                              ),
                              trailing: Text(
                                AppFormatters.grade(g.value),
                                style: AppTypography.titleMedium.copyWith(
                                  color: g.value >= sub.passingGrade ? Colors.green : Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                );
              }),
              const SizedBox(height: AppSpacing.lg),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
