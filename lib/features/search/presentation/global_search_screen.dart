import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/design_system/app_radius.dart';
import '../../../core/design_system/app_scroll_physics.dart';
import '../../../core/design_system/app_spacing.dart';
import '../../../core/design_system/app_typography.dart';
import '../../../core/design_system/components/app_card.dart';
import '../../../core/utils/formatters.dart';
import '../../exams/data/exam_repository.dart';
import '../../grades/data/grade_repository.dart';
import '../../subjects/data/subject_repository.dart';
import '../../topics/data/topic_repository.dart';

class GlobalSearchScreen extends ConsumerStatefulWidget {
  const GlobalSearchScreen({super.key});

  @override
  ConsumerState<GlobalSearchScreen> createState() => _GlobalSearchScreenState();
}

class _GlobalSearchScreenState extends ConsumerState<GlobalSearchScreen> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final subjects = ref.watch(subjectsStreamProvider).value ?? [];
    final exams = ref.watch(examsStreamProvider).value ?? [];
    final topics = ref.watch(allTopicsStreamProvider).value ?? [];
    final grades = ref.watch(allGradesStreamProvider).value ?? [];

    final q = _query.toLowerCase().trim();

    final matchingSubjects = q.isEmpty
        ? []
        : subjects
            .where((s) =>
                s.name.toLowerCase().contains(q) ||
                (s.code?.toLowerCase().contains(q) ?? false) ||
                (s.professor?.toLowerCase().contains(q) ?? false))
            .toList();

    final matchingExams = q.isEmpty
        ? []
        : exams
            .where((e) =>
                e.title.toLowerCase().contains(q) ||
                (e.classroom?.toLowerCase().contains(q) ?? false) ||
                e.type.label.toLowerCase().contains(q))
            .toList();

    final matchingTopics = q.isEmpty
        ? []
        : topics
            .where((t) =>
                t.title.toLowerCase().contains(q) ||
                (t.notes?.toLowerCase().contains(q) ?? false))
            .toList();

    final matchingGrades = q.isEmpty
        ? []
        : grades.where((g) => g.title.toLowerCase().contains(q)).toList();

    final totalResults = matchingSubjects.length +
        matchingExams.length +
        matchingTopics.length +
        matchingGrades.length;

    return Scaffold(
      appBar: AppBar(
        title: Container(
          decoration: ShapeDecoration(
            color: isDark ? const Color(0xFF1E222A) : const Color(0xFFF3F4F6),
            shape: AppRadius.continuousMd(),
          ),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: TextField(
            controller: _searchController,
            autofocus: true,
            onChanged: (val) => setState(() => _query = val),
            style: AppTypography.bodyMedium.copyWith(
              color: isDark ? Colors.white : const Color(0xFF111827),
            ),
            decoration: InputDecoration(
              icon: const Icon(Icons.search_rounded, size: 20),
              suffixIcon: _query.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear_rounded, size: 18),
                      onPressed: () {
                        _searchController.clear();
                        setState(() => _query = '');
                      },
                    )
                  : null,
              border: InputBorder.none,
              hintText: 'Buscar materias, exámenes, temas, notas...',
            ),
          ),
        ),
      ),
      body: q.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search_rounded, size: 48, color: Colors.grey.withValues(alpha: 0.5)),
                  const SizedBox(height: AppSpacing.sm),
                  const Text('Escribí para buscar en toda tu vida académica', style: AppTypography.bodyMedium),
                ],
              ),
            )
          : totalResults == 0
              ? const Center(
                  child: Text('No se encontraron resultados', style: AppTypography.titleMedium),
                )
              : ListView(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  physics: appScrollPhysics(),
                  children: [
                    if (matchingSubjects.isNotEmpty) ...[
                      Text('Materias (${matchingSubjects.length})', style: AppTypography.titleSmall),
                      const SizedBox(height: AppSpacing.xs),
                      ...matchingSubjects.map((s) => Padding(
                            padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                            child: AppCard(
                              onTap: () => context.push('/subjects/${s.id}'),
                              child: ListTile(
                                dense: true,
                                contentPadding: EdgeInsets.zero,
                                leading: Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(color: Color(s.colorValue), shape: BoxShape.circle),
                                ),
                                title: Text(s.name, style: AppTypography.titleSmall),
                                subtitle: Text(s.code ?? s.status.label),
                                trailing: const Icon(Icons.chevron_right_rounded),
                              ),
                            ),
                          )),
                      const SizedBox(height: AppSpacing.md),
                    ],

                    if (matchingExams.isNotEmpty) ...[
                      Text('Evaluaciones (${matchingExams.length})', style: AppTypography.titleSmall),
                      const SizedBox(height: AppSpacing.xs),
                      ...matchingExams.map((e) => Padding(
                            padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                            child: AppCard(
                              onTap: () => context.push('/exams/${e.id}'),
                              child: ListTile(
                                dense: true,
                                contentPadding: EdgeInsets.zero,
                                leading: const Icon(Icons.assignment_rounded, color: Colors.blue),
                                title: Text(e.title, style: AppTypography.titleSmall),
                                subtitle: Text('${AppFormatters.date(e.dateTime)} · ${e.type.label}'),
                                trailing: const Icon(Icons.chevron_right_rounded),
                              ),
                            ),
                          )),
                      const SizedBox(height: AppSpacing.md),
                    ],

                    if (matchingTopics.isNotEmpty) ...[
                      Text('Temas de estudio (${matchingTopics.length})', style: AppTypography.titleSmall),
                      const SizedBox(height: AppSpacing.xs),
                      ...matchingTopics.map((t) => Padding(
                            padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                            child: AppCard(
                              child: ListTile(
                                dense: true,
                                contentPadding: EdgeInsets.zero,
                                leading: const Icon(Icons.checklist_rounded, color: Colors.amber),
                                title: Text(t.title, style: AppTypography.titleSmall),
                                subtitle: Text('Estado: ${t.status.label} · Prioridad: ${t.priority.label}'),
                              ),
                            ),
                          )),
                      const SizedBox(height: AppSpacing.md),
                    ],

                    if (matchingGrades.isNotEmpty) ...[
                      Text('Calificaciones (${matchingGrades.length})', style: AppTypography.titleSmall),
                      const SizedBox(height: AppSpacing.xs),
                      ...matchingGrades.map((g) => Padding(
                            padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                            child: AppCard(
                              child: ListTile(
                                dense: true,
                                contentPadding: EdgeInsets.zero,
                                leading: const Icon(Icons.star_rounded, color: Colors.green),
                                title: Text(g.title, style: AppTypography.titleSmall),
                                subtitle: Text(AppFormatters.date(g.date)),
                                trailing: Text(
                                  AppFormatters.grade(g.value),
                                  style: AppTypography.titleMedium.copyWith(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          )),
                      const SizedBox(height: AppSpacing.md),
                    ],
                  ],
                ),
    );
  }
}
