import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/design_system/app_radius.dart';
import '../../../core/design_system/app_spacing.dart';
import '../../../core/design_system/app_typography.dart';
import '../../../core/design_system/components/app_card.dart';
import '../../../core/design_system/components/app_button.dart';
import '../../../core/design_system/components/empty_state.dart';
import '../../../core/design_system/components/pressable_scale.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/l10n/app_strings.dart';
import '../../subjects/data/subject_repository.dart';
import '../../topics/data/topic_repository.dart';
import '../../topics/domain/topic.dart';
import '../../topics/presentation/topic_controller.dart';
import '../../topics/presentation/upsert_topic_sheet.dart';
import '../../grades/presentation/upsert_grade_sheet.dart';
import '../data/exam_repository.dart';
import 'exam_controller.dart';
import 'upsert_exam_sheet.dart';

class ExamDetailScreen extends ConsumerWidget {
  final String examId;
  const ExamDetailScreen({super.key, required this.examId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final examsAsync = ref.watch(examsStreamProvider);
    final exam = examsAsync.value?.where((e) => e.id == examId).firstOrNull;

    if (exam == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('Evaluación no encontrada')),
      );
    }

    final subjectsAsync = ref.watch(subjectsStreamProvider);
    final subject = subjectsAsync.value?.where((s) => s.id == exam.subjectId).firstOrNull;
    final subjectColor = subject != null ? Color(subject.colorValue) : theme.colorScheme.primary;

    final topicsAsync = ref.watch(examTopicsStreamProvider(exam.id));
    final topics = topicsAsync.value ?? [];

    double progress = 0.0;
    if (topics.isNotEmpty) {
      double total = 0.0;
      for (final t in topics) {
        total += t.status.progressValue;
      }
      progress = total / topics.length;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(exam.type.label, style: AppTypography.titleLarge),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () => UpsertExamSheet.show(context, examToEdit: exam),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline_rounded),
            onPressed: () async {
              final confirmed = await showDialog<bool>(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('¿Eliminar examen?'),
                  content: Text('Se ocultará "${exam.title}". Podés deshacer la acción.'),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancelar')),
                    TextButton(
                      onPressed: () => Navigator.pop(ctx, true),
                      child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              );
              if (confirmed == true && context.mounted) {
                ref.read(examControllerProvider.notifier).deleteExam(exam.id);
                context.pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Se eliminó ${exam.title}'),
                    action: SnackBarAction(
                      label: AppStrings.undo,
                      onPressed: () {
                        ref.read(examControllerProvider.notifier).restoreExam(exam.id);
                      },
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        physics: const BouncingScrollPhysics(),
        children: [
          // Header Card
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (subject != null)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: ShapeDecoration(
                          color: subjectColor.withValues(alpha: 0.15),
                          shape: AppRadius.continuousSm(),
                        ),
                        child: Text(
                          subject.name,
                          style: AppTypography.caption.copyWith(
                            color: subjectColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: ShapeDecoration(
                        color: Colors.amber.withValues(alpha: 0.15),
                        shape: AppRadius.continuousSm(),
                      ),
                      child: Text(
                        AppFormatters.countdown(exam.dateTime),
                        style: AppTypography.caption.copyWith(
                          color: Colors.amber[800],
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  exam.title,
                  style: AppTypography.display.copyWith(fontSize: 24),
                ),
                const SizedBox(height: AppSpacing.md),
                Row(
                  children: [
                    const Icon(Icons.calendar_today_rounded, size: 16, color: Colors.grey),
                    const SizedBox(width: 6),
                    Text(
                      '${AppFormatters.date(exam.dateTime)} · ${AppFormatters.time(exam.dateTime)} hs (${exam.durationMinutes} min)',
                      style: AppTypography.bodyMedium,
                    ),
                  ],
                ),
                if (exam.classroom != null) ...[
                  const SizedBox(height: AppSpacing.xs),
                  Row(
                    children: [
                      const Icon(Icons.room_outlined, size: 16, color: Colors.grey),
                      const SizedBox(width: 6),
                      Text(exam.classroom!, style: AppTypography.bodyMedium),
                    ],
                  ),
                ],
                const SizedBox(height: AppSpacing.lg),
                // Action: Cargar nota
                Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        label: 'Registrar calificación',
                        icon: Icons.grade_rounded,
                        variant: AppButtonVariant.secondary,
                        onPressed: () => UpsertGradeSheet.show(
                          context,
                          preselectedSubjectId: exam.subjectId,
                          preselectedExamId: exam.id,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),

          // Study Progress Card
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(AppStrings.topics, style: AppTypography.titleMedium),
                    Text(
                      '${(progress * 100).toInt()}% preparado',
                      style: AppTypography.caption.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 8,
                    backgroundColor: isDark ? const Color(0xFF262A32) : const Color(0xFFE5E7EB),
                    valueColor: AlwaysStoppedAnimation<Color>(theme.colorScheme.primary),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  'Tocá el círculo de un tema para cambiar su estado (Sin empezar ➔ Estudiando ➔ Repasado ➔ Dominado). Arrastrá para reordenar.',
                  style: AppTypography.caption.copyWith(color: Colors.grey),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),

          // Topics Reorderable List
          if (topics.isEmpty)
            EmptyState(
              icon: Icons.checklist_rounded,
              title: 'Sin temas asignados',
              description: 'Sumá temas para desglosar el examen y estudiar mejor.',
              actionLabel: AppStrings.addTopic,
              onAction: () => UpsertTopicSheet.show(
                context,
                subjectId: exam.subjectId,
                examId: exam.id,
              ),
            )
          else ...[
            ReorderableListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: topics.length,
              onReorderItem: (oldIndex, newIndex) {
                ref.read(topicControllerProvider.notifier).reorderTopics(
                      List.of(topics),
                      oldIndex,
                      newIndex,
                    );
              },
              itemBuilder: (context, index) {
                final t = topics[index];
                return Padding(
                  key: Key(t.id),
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: AppCard(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: 12),
                    child: Row(
                      children: [
                        // Tap to cycle status
                        PressableScale(
                          onTap: () => ref.read(topicControllerProvider.notifier).toggleStatus(t),
                          child: Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              color: _topicStatusColor(t.status).withValues(alpha: 0.2),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: _topicStatusColor(t.status),
                                width: 2,
                              ),
                            ),
                            child: Icon(
                              _topicStatusIcon(t.status),
                              size: 16,
                              color: _topicStatusColor(t.status),
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => UpsertTopicSheet.show(
                              context,
                              subjectId: exam.subjectId,
                              examId: exam.id,
                              topicToEdit: t,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  t.title,
                                  style: AppTypography.titleSmall.copyWith(
                                    decoration: t.status == TopicStatus.mastered
                                        ? TextDecoration.lineThrough
                                        : null,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      t.status.label,
                                      style: AppTypography.caption.copyWith(
                                        color: _topicStatusColor(t.status),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Prioridad ${t.priority.label}',
                                      style: AppTypography.caption.copyWith(color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Drag Handle
                        ReorderableDragStartListener(
                          index: index,
                          child: const Icon(Icons.drag_indicator_rounded, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: AppSpacing.md),
            Center(
              child: AppButton(
                label: 'Agregar otro tema',
                icon: Icons.add_rounded,
                variant: AppButtonVariant.secondary,
                onPressed: () => UpsertTopicSheet.show(
                  context,
                  subjectId: exam.subjectId,
                  examId: exam.id,
                ),
              ),
            ),
          ],
          const SizedBox(height: 60),
        ],
      ),
    );
  }

  Color _topicStatusColor(TopicStatus status) {
    switch (status) {
      case TopicStatus.todo:
        return Colors.grey;
      case TopicStatus.studying:
        return Colors.amber;
      case TopicStatus.reviewed:
        return Colors.blue;
      case TopicStatus.mastered:
        return Colors.green;
    }
  }

  IconData _topicStatusIcon(TopicStatus status) {
    switch (status) {
      case TopicStatus.todo:
        return Icons.circle_outlined;
      case TopicStatus.studying:
        return Icons.hourglass_top_rounded;
      case TopicStatus.reviewed:
        return Icons.refresh_rounded;
      case TopicStatus.mastered:
        return Icons.check;
    }
  }
}
