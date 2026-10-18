import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/design_system/app_colors.dart';
import '../../../core/design_system/app_radius.dart';
import '../../../core/design_system/app_spacing.dart';
import '../../../core/design_system/app_typography.dart';
import '../../../core/design_system/components/animated_counter.dart';
import '../../../core/design_system/components/app_card.dart';
import '../../../core/design_system/components/pressable_scale.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/l10n/app_strings.dart';
import '../../profile/data/profile_repository.dart';
import '../../profile/presentation/avatar_view.dart';
import '../../subjects/data/subject_repository.dart';
import '../../exams/data/exam_repository.dart';
import '../../exams/presentation/upsert_exam_sheet.dart';
import '../../subjects/presentation/upsert_subject_sheet.dart';
import '../../grades/data/grade_repository.dart';
import '../../grades/presentation/grade_controller.dart';
import '../../grades/presentation/upsert_grade_sheet.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final profileAsync = ref.watch(profileStreamProvider);
    final profile = profileAsync.value;

    final examsAsync = ref.watch(examsStreamProvider);
    final subjectsAsync = ref.watch(subjectsStreamProvider);
    final gradesAsync = ref.watch(allGradesStreamProvider);

    final allExams = examsAsync.value ?? [];
    final allSubjects = subjectsAsync.value ?? [];
    final allGrades = gradesAsync.value ?? [];

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    // Upcoming exams sorted by date
    final upcomingExams = allExams
        .where((e) => e.dateTime.isAfter(today.subtract(const Duration(hours: 1))))
        .toList()
      ..sort((a, b) => a.dateTime.compareTo(b.dateTime));

    final nextExam = upcomingExams.isNotEmpty ? upcomingExams.first : null;

    // This week's exams (next 7 days)
    final thisWeekExams = upcomingExams.where((e) {
      final diff = e.dateTime.difference(today).inDays;
      return diff >= 0 && diff <= 7;
    }).toList();

    // Past exams without loaded grades
    final pastExamsWithoutGrade = allExams.where((e) {
      final isPast = e.dateTime.isBefore(today);
      final hasGrade = allGrades.any((g) => g.examId == e.id);
      return isPast && !hasGrade;
    }).toList();

    // General Average
    final overallAverage = GradeCalculations.calculateAverage(allGrades);

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          physics: const BouncingScrollPhysics(),
          children: [
            // Header with Student Greeting & Avatar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '¡Hola, ${profile?.fullName.split(' ').first ?? 'Estudiante'}!',
                        style: AppTypography.display.copyWith(
                          fontSize: 26,
                          color: AppColors.textPrimary(context),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${profile?.career ?? 'Universidad'} · ${profile?.currentPeriod ?? ''}',
                        style: AppTypography.caption.copyWith(
                          color: AppColors.textSecondary(context),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  tooltip: 'Buscar en la app',
                  onPressed: () => context.push('/search'),
                  icon: const Icon(Icons.search_rounded),
                ),
                const SizedBox(width: AppSpacing.xs),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => context.go('/settings'),
                    customBorder: const CircleBorder(),
                    child: Padding(
                      padding: const EdgeInsets.all(2),
                      child: AvatarView(
                        photoPath: profile?.photoPath,
                        name: profile?.fullName ?? 'A',
                        size: 44,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),

            // Quick Actions Bar (+ Evaluación, + Nota, + Materia)
            Row(
              children: [
                Expanded(
                  child: _QuickActionButton(
                    icon: Icons.assignment_add,
                    label: 'Examen',
                    color: theme.colorScheme.primary,
                    onTap: () => UpsertExamSheet.show(context),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: _QuickActionButton(
                    icon: Icons.grade_rounded,
                    label: 'Nota',
                    color: AppColors.success,
                    onTap: () => UpsertGradeSheet.show(context),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: _QuickActionButton(
                    icon: Icons.bookmark_add_rounded,
                    label: 'Materia',
                    color: const Color(0xFF7C3AED),
                    onTap: () => UpsertSubjectSheet.show(context),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),

            // Featured Next Exam Countdown Card
            if (nextExam != null) ...[
              Text(
                'Próxima evaluación',
                style: AppTypography.titleMedium.copyWith(
                  color: AppColors.textPrimary(context),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              _FeaturedExamCard(
                exam: nextExam,
                subject: allSubjects.where((s) => s.id == nextExam.subjectId).firstOrNull,
              ),
              const SizedBox(height: AppSpacing.xl),
            ],

            // Overdue Exams without grade loaded
            if (pastExamsWithoutGrade.isNotEmpty) ...[
              AppCard(
                color: AppColors.warning.withValues(alpha: isDark ? 0.16 : 0.08),
                border: BorderSide(
                  color: AppColors.warning.withValues(alpha: isDark ? 0.35 : 0.25),
                  width: 1,
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.pending_actions_rounded,
                      color: AppColors.warning,
                      size: 26,
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${pastExamsWithoutGrade.length} exámenes pendientes de nota',
                            style: AppTypography.titleSmall.copyWith(
                              color: AppColors.warning,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '¿Ya te dieron la calificación de "${pastExamsWithoutGrade.first.title}"?',
                            style: AppTypography.caption.copyWith(
                              color: AppColors.textSecondary(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                    PressableScale(
                      enableHaptics: true,
                      onTap: () => UpsertGradeSheet.show(
                        context,
                        preselectedSubjectId: pastExamsWithoutGrade.first.subjectId,
                        preselectedExamId: pastExamsWithoutGrade.first.id,
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                        decoration: ShapeDecoration(
                          color: AppColors.warning,
                          shape: AppRadius.continuousSm(),
                        ),
                        child: const Text(
                          'Cargar',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
            ],

            // Academic Status Overview (Average & Subjects count)
            Row(
              children: [
                Expanded(
                  child: AppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.overallAverage,
                          style: AppTypography.eyebrow.copyWith(
                            color: AppColors.textSecondary(context),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        allGrades.isNotEmpty
                            ? AnimatedCounter(
                                value: overallAverage,
                                precision: 2,
                                style: AppTypography.statNumber.copyWith(
                                  color: overallAverage >= (profile?.passingGrade ?? 4.0)
                                      ? AppColors.success
                                      : AppColors.error,
                                ),
                              )
                            : Text(
                                '-',
                                style: AppTypography.statNumber.copyWith(
                                  color: AppColors.textPrimary(context),
                                ),
                              ),
                        const SizedBox(height: 2),
                        Text(
                          allGrades.isNotEmpty ? '${allGrades.length} notas' : 'Sin notas',
                          style: AppTypography.caption.copyWith(
                            color: AppColors.textTertiary(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: AppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'MATERIAS CURSANDO',
                          style: AppTypography.eyebrow.copyWith(
                            color: AppColors.textSecondary(context),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        AnimatedCounter(
                          value: allSubjects.length.toDouble(),
                          precision: 0,
                          style: AppTypography.statNumber.copyWith(
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${allExams.length} exámenes total',
                          style: AppTypography.caption.copyWith(
                            color: AppColors.textTertiary(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),

            // This Week Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Esta semana',
                  style: AppTypography.titleMedium.copyWith(
                    color: AppColors.textPrimary(context),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextButton(
                  onPressed: () => context.go('/calendar'),
                  child: const Text('Ver calendario'),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xs),
            if (thisWeekExams.isEmpty)
              AppCard(
                child: Row(
                  children: [
                    const Icon(
                      Icons.check_circle_outline_rounded,
                      color: AppColors.success,
                      size: 24,
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '¡Semana tranquila!',
                            style: AppTypography.titleSmall.copyWith(
                              color: AppColors.textPrimary(context),
                            ),
                          ),
                          Text(
                            'No tenés exámenes programados para los próximos 7 días.',
                            style: AppTypography.caption.copyWith(
                              color: AppColors.textSecondary(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            else
              ...thisWeekExams.map((e) {
                final sub = allSubjects.where((s) => s.id == e.subjectId).firstOrNull;
                final subColor = sub != null ? Color(sub.colorValue) : theme.colorScheme.primary;

                return Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: AppCard(
                    onTap: () => context.push('/exams/${e.id}'),
                    child: Row(
                      children: [
                        Container(
                          width: 4,
                          height: 40,
                          decoration: BoxDecoration(
                            color: subColor,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                e.title,
                                style: AppTypography.titleSmall.copyWith(
                                  color: AppColors.textPrimary(context),
                                ),
                              ),
                              Text(
                                '${sub?.name ?? ''} · ${AppFormatters.date(e.dateTime)} ${AppFormatters.time(e.dateTime)}',
                                style: AppTypography.caption.copyWith(
                                  color: AppColors.textTertiary(context),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: ShapeDecoration(
                            color: AppColors.warning.withValues(alpha: isDark ? 0.20 : 0.12),
                            shape: AppRadius.continuousSm(
                              side: BorderSide(
                                color: AppColors.warning.withValues(alpha: isDark ? 0.35 : 0.20),
                              ),
                            ),
                          ),
                          child: Text(
                            AppFormatters.countdown(e.dateTime),
                            style: AppTypography.caption.copyWith(
                              color: AppColors.warning,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            const SizedBox(height: AppSpacing.lg),
          ],
        ),
      ),
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return PressableScale(
      enableHaptics: true,
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: ShapeDecoration(
          color: color.withValues(alpha: isDark ? 0.16 : 0.08),
          shape: AppRadius.continuousMd(
            side: BorderSide(
              color: color.withValues(alpha: isDark ? 0.32 : 0.20),
              width: 1,
            ),
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 5),
            Text(
              '+ $label',
              style: AppTypography.caption.copyWith(
                color: color,
                fontWeight: FontWeight.w700,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeaturedExamCard extends StatelessWidget {
  final dynamic exam;
  final dynamic subject;

  const _FeaturedExamCard({required this.exam, required this.subject});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final subjectColor = subject != null ? Color(subject.colorValue) : theme.colorScheme.primary;

    return AppCard(
      onTap: () => context.push('/exams/${exam.id}'),
      color: isDark ? AppColors.darkSurfaceElevated : AppColors.lightSurface,
      border: BorderSide(
        color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
        width: 1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: ShapeDecoration(
                  color: subjectColor.withValues(alpha: isDark ? 0.22 : 0.12),
                  shape: AppRadius.continuousSm(
                    side: BorderSide(
                      color: subjectColor.withValues(alpha: isDark ? 0.40 : 0.25),
                    ),
                  ),
                ),
                child: Text(
                  subject?.name ?? 'Materia',
                  style: AppTypography.caption.copyWith(
                    color: subjectColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: ShapeDecoration(
                  color: AppColors.error.withValues(alpha: isDark ? 0.20 : 0.10),
                  shape: AppRadius.continuousSm(
                    side: BorderSide(
                      color: AppColors.error.withValues(alpha: isDark ? 0.40 : 0.25),
                    ),
                  ),
                ),
                child: Text(
                  AppFormatters.countdown(exam.dateTime),
                  style: TextStyle(
                    color: AppColors.error,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            exam.title,
            style: AppTypography.titleLarge.copyWith(
              color: AppColors.textPrimary(context),
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Row(
            children: [
              Icon(
                Icons.calendar_today_rounded,
                size: 14,
                color: AppColors.textTertiary(context),
              ),
              const SizedBox(width: 5),
              Text(
                '${AppFormatters.date(exam.dateTime)} · ${AppFormatters.time(exam.dateTime)} hs',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textSecondary(context),
                ),
              ),
              if (exam.classroom != null) ...[
                const SizedBox(width: 12),
                Icon(
                  Icons.room_outlined,
                  size: 14,
                  color: AppColors.textTertiary(context),
                ),
                const SizedBox(width: 5),
                Text(
                  exam.classroom!,
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textSecondary(context),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
