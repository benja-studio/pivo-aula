import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/design_system/app_radius.dart';
import '../../../core/design_system/app_spacing.dart';
import '../../../core/design_system/app_typography.dart';
import '../../../core/design_system/components/app_card.dart';
import '../../../core/design_system/components/app_button.dart';
import '../../../core/design_system/components/empty_state.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/l10n/app_strings.dart';
import '../../exams/data/exam_repository.dart';
import '../../exams/presentation/upsert_exam_sheet.dart';
import '../../topics/data/topic_repository.dart';
import '../../topics/domain/topic.dart';
import '../../topics/presentation/upsert_topic_sheet.dart';
import '../../grades/data/grade_repository.dart';
import '../../grades/presentation/upsert_grade_sheet.dart';
import '../data/subject_repository.dart';
import '../domain/subject.dart';
import 'subject_controller.dart';
import 'upsert_subject_sheet.dart';

class SubjectDetailScreen extends ConsumerStatefulWidget {
  final String subjectId;
  const SubjectDetailScreen({super.key, required this.subjectId});

  @override
  ConsumerState<SubjectDetailScreen> createState() => _SubjectDetailScreenState();
}

class _SubjectDetailScreenState extends ConsumerState<SubjectDetailScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final subjectsAsync = ref.watch(subjectsStreamProvider);

    return subjectsAsync.when(
      data: (subjects) {
        final subject = subjects.where((s) => s.id == widget.subjectId).firstOrNull;
        if (subject == null) {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(child: Text('Materia no encontrada')),
          );
        }

        final subjectColor = Color(subject.colorValue);

        return Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  expandedHeight: 200.0,
                  pinned: true,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back_rounded),
                    onPressed: () => context.pop(),
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.edit_outlined),
                      onPressed: () => UpsertSubjectSheet.show(
                        context,
                        subjectToEdit: subject,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline_rounded),
                      onPressed: () async {
                        final navigator = Navigator.of(context);
                        final messenger = ScaffoldMessenger.of(context);
                        final confirmed = await showDialog<bool>(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text('¿Eliminar materia?'),
                            content: Text('Se ocultará "${subject.name}".'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(ctx, false),
                                child: const Text('Cancelar'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(ctx, true),
                                child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
                              ),
                            ],
                          ),
                        );
                        if (confirmed == true && mounted) {
                          ref.read(subjectControllerProvider.notifier).deleteSubject(subject.id);
                          navigator.pop();
                          messenger.showSnackBar(
                            SnackBar(
                              content: Text('Se eliminó ${subject.name}'),
                              action: SnackBarAction(
                                label: AppStrings.undo,
                                onPressed: () {
                                  ref.read(subjectControllerProvider.notifier).restoreSubject(subject.id);
                                },
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            subjectColor.withValues(alpha: isDark ? 0.35 : 0.2),
                            isDark ? const Color(0xFF0F1115) : const Color(0xFFF8F9FA),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      padding: const EdgeInsets.fromLTRB(
                        AppSpacing.lg,
                        kToolbarHeight + AppSpacing.md,
                        AppSpacing.lg,
                        AppSpacing.sm,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Hero(
                                tag: 'subject_icon_${subject.id}',
                                child: Container(
                                  width: 44,
                                  height: 44,
                                  decoration: ShapeDecoration(
                                    color: subjectColor,
                                    shape: AppRadius.continuousMd(),
                                  ),
                                  child: Icon(
                                    IconData(subject.iconCode, fontFamily: 'MaterialIcons'),
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ),
                              ),
                              const SizedBox(width: AppSpacing.md),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      subject.name,
                                      style: AppTypography.titleLarge.copyWith(
                                        color: isDark ? Colors.white : const Color(0xFF111827),
                                      ),
                                    ),
                                    if (subject.code != null)
                                      Text(
                                        subject.code!,
                                        style: AppTypography.caption.copyWith(
                                          color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.md),
                          Row(
                            children: [
                              if (subject.professor != null) ...[
                                const Icon(Icons.person_outline_rounded, size: 14, color: Colors.grey),
                                const SizedBox(width: 4),
                                Text(
                                  subject.professor!,
                                  style: AppTypography.caption.copyWith(
                                    color: isDark ? const Color(0xFFD1D5DB) : const Color(0xFF4B5563),
                                  ),
                                ),
                                const SizedBox(width: 12),
                              ],
                              if (subject.classroom != null) ...[
                                const Icon(Icons.room_outlined, size: 14, color: Colors.grey),
                                const SizedBox(width: 4),
                                Text(
                                  subject.classroom!,
                                  style: AppTypography.caption.copyWith(
                                    color: isDark ? const Color(0xFFD1D5DB) : const Color(0xFF4B5563),
                                  ),
                                ),
                              ],
                              const Spacer(),
                              Text(
                                'Aprueba con ${subject.passingGrade.toStringAsFixed(1)}',
                                style: AppTypography.caption.copyWith(
                                  color: subjectColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  bottom: TabBar(
                    controller: _tabController,
                    indicatorColor: subjectColor,
                    labelColor: subjectColor,
                    unselectedLabelColor: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
                    tabs: const [
                      Tab(text: 'Exámenes'),
                      Tab(text: 'Temas'),
                      Tab(text: 'Notas'),
                    ],
                  ),
                ),
              ];
            },
            body: TabBarView(
              controller: _tabController,
              children: [
                _SubjectExamsTab(subject: subject),
                _SubjectTopicsTab(subject: subject),
                _SubjectGradesTab(subject: subject),
              ],
            ),
          ),
        );
      },
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('Error: $e'))),
    );
  }
}

class _SubjectExamsTab extends ConsumerWidget {
  final Subject subject;
  const _SubjectExamsTab({required this.subject});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final examsAsync = ref.watch(examsStreamProvider);

    return examsAsync.when(
      data: (allExams) {
        final exams = allExams.where((e) => e.subjectId == subject.id).toList();

        if (exams.isEmpty) {
          return EmptyState(
            icon: Icons.event_note_rounded,
            title: 'Sin exámenes programados',
            description: 'Agregá parciales, recuperatorios, entregas o finales.',
            actionLabel: 'Nuevo examen',
            onAction: () => UpsertExamSheet.show(context, preselectedSubjectId: subject.id),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(AppSpacing.lg),
          itemCount: exams.length + 1,
          itemBuilder: (context, index) {
            if (index == exams.length) {
              return Padding(
                padding: const EdgeInsets.only(top: AppSpacing.sm, bottom: 40),
                child: Center(
                  child: AppButton(
                    label: 'Agregar examen',
                    icon: Icons.add_rounded,
                    variant: AppButtonVariant.secondary,
                    onPressed: () => UpsertExamSheet.show(
                      context,
                      preselectedSubjectId: subject.id,
                    ),
                  ),
                ),
              );
            }

            final exam = exams[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: AppCard(
                onTap: () => UpsertExamSheet.show(context, examToEdit: exam),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: ShapeDecoration(
                            color: Color(subject.colorValue).withValues(alpha: 0.15),
                            shape: AppRadius.continuousSm(),
                          ),
                          child: Text(
                            exam.type.label,
                            style: AppTypography.caption.copyWith(
                              color: Color(subject.colorValue),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          AppFormatters.countdown(exam.dateTime),
                          style: AppTypography.caption.copyWith(
                            color: Colors.amber[800],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(exam.title, style: AppTypography.titleMedium),
                    const SizedBox(height: AppSpacing.xs),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today_rounded, size: 14, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          '${AppFormatters.date(exam.dateTime)} · ${AppFormatters.time(exam.dateTime)}',
                          style: AppTypography.caption,
                        ),
                        if (exam.classroom != null) ...[
                          const SizedBox(width: 12),
                          const Icon(Icons.room_outlined, size: 14, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(exam.classroom!, style: AppTypography.caption),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
    );
  }
}

class _SubjectTopicsTab extends ConsumerWidget {
  final Subject subject;
  const _SubjectTopicsTab({required this.subject});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topicsAsync = ref.watch(subjectTopicsStreamProvider(subject.id));

    return topicsAsync.when(
      data: (topics) {
        if (topics.isEmpty) {
          return EmptyState(
            icon: Icons.checklist_rounded,
            title: 'Sin temas cargados',
            description: 'Organizá los temas para estudiar y llevar tu progreso.',
            actionLabel: 'Nuevo tema',
            onAction: () => UpsertTopicSheet.show(context, subjectId: subject.id),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(AppSpacing.lg),
          itemCount: topics.length + 1,
          itemBuilder: (context, index) {
            if (index == topics.length) {
              return Padding(
                padding: const EdgeInsets.only(top: AppSpacing.sm, bottom: 40),
                child: Center(
                  child: AppButton(
                    label: 'Agregar tema',
                    icon: Icons.add_rounded,
                    variant: AppButtonVariant.secondary,
                    onPressed: () => UpsertTopicSheet.show(context, subjectId: subject.id),
                  ),
                ),
              );
            }

            final t = topics[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: AppCard(
                onTap: () => UpsertTopicSheet.show(context, subjectId: subject.id, topicToEdit: t),
                child: Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: t.status == TopicStatus.mastered
                            ? Colors.green
                            : (t.status == TopicStatus.studying ? Colors.amber : Colors.grey),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(t.title, style: AppTypography.titleSmall),
                          Text(
                            '${t.status.label} · Prioridad ${t.priority.label}',
                            style: AppTypography.caption.copyWith(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
    );
  }
}

class _SubjectGradesTab extends ConsumerWidget {
  final Subject subject;
  const _SubjectGradesTab({required this.subject});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gradesAsync = ref.watch(subjectGradesStreamProvider(subject.id));

    return gradesAsync.when(
      data: (grades) {
        if (grades.isEmpty) {
          return EmptyState(
            icon: Icons.grade_rounded,
            title: 'Sin calificaciones registradas',
            description: 'Cargá notas de parciales, entregas o TPs.',
            actionLabel: 'Nueva nota',
            onAction: () => UpsertGradeSheet.show(context, preselectedSubjectId: subject.id),
          );
        }

        // Calculate average
        double sum = 0;
        double totalWeight = 0;
        for (final g in grades) {
          sum += g.value * g.weight;
          totalWeight += g.weight;
        }
        final average = totalWeight > 0 ? sum / totalWeight : 0.0;
        final isPassing = average >= subject.passingGrade;

        return ListView.builder(
          padding: const EdgeInsets.all(AppSpacing.lg),
          itemCount: grades.length + 2,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.lg),
                child: AppCard(
                  color: isPassing
                      ? Colors.green.withValues(alpha: 0.12)
                      : Colors.red.withValues(alpha: 0.12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Promedio ponderado', style: AppTypography.titleSmall),
                          Text(
                            isPassing ? 'En condición de aprobar' : 'Por debajo de la aprobación',
                            style: AppTypography.caption.copyWith(
                              color: isPassing ? Colors.green[800] : Colors.red[800],
                            ),
                          ),
                        ],
                      ),
                      Text(
                        AppFormatters.grade(average),
                        style: AppTypography.display.copyWith(
                          color: isPassing ? Colors.green : Colors.red,
                          fontSize: 32,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            if (index == grades.length + 1) {
              return Padding(
                padding: const EdgeInsets.only(top: AppSpacing.sm, bottom: 40),
                child: Center(
                  child: AppButton(
                    label: 'Registrar nota',
                    icon: Icons.add_rounded,
                    variant: AppButtonVariant.secondary,
                    onPressed: () => UpsertGradeSheet.show(
                      context,
                      preselectedSubjectId: subject.id,
                    ),
                  ),
                ),
              );
            }

            final g = grades[index - 1];
            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: AppCard(
                onTap: () => UpsertGradeSheet.show(context, gradeToEdit: g),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(g.title, style: AppTypography.titleSmall),
                          Text(
                            '${g.kind.label} · Peso ${g.weight.toStringAsFixed(0)} · ${AppFormatters.date(g.date)}',
                            style: AppTypography.caption.copyWith(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      AppFormatters.grade(g.value),
                      style: AppTypography.titleLarge.copyWith(
                        color: g.value >= subject.passingGrade ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
    );
  }
}
