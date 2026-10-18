import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/design_system/app_radius.dart';
import '../../../core/design_system/app_spacing.dart';
import '../../../core/design_system/app_typography.dart';
import '../../../core/design_system/components/app_card.dart';
import '../../../core/design_system/components/app_chip.dart';
import '../../../core/design_system/components/empty_state.dart';
import '../../../core/design_system/components/pressable_scale.dart';
import '../../../core/l10n/app_strings.dart';
import '../data/subject_repository.dart';
import '../domain/subject.dart';
import '../domain/subject_icons.dart';
import 'subject_controller.dart';
import 'upsert_subject_sheet.dart';

class SubjectsScreen extends ConsumerStatefulWidget {
  const SubjectsScreen({super.key});

  @override
  ConsumerState<SubjectsScreen> createState() => _SubjectsScreenState();
}

class _SubjectsScreenState extends ConsumerState<SubjectsScreen> {
  SubjectStatus? _selectedStatusFilter;
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final subjectsAsync = ref.watch(subjectsStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppStrings.subjectsTitle,
          style: AppTypography.titleLarge,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.md),
            child: PressableScale(
              onTap: () => UpsertSubjectSheet.show(context),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.xs + 2,
                ),
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
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: subjectsAsync.when(
        data: (subjects) {
          final filtered = subjects.where((s) {
            final matchesStatus = _selectedStatusFilter == null || s.status == _selectedStatusFilter;
            final matchesSearch = _searchQuery.isEmpty ||
                s.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                (s.code?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false);
            return matchesStatus && matchesSearch;
          }).toList();

          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // Search & Filter Header
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    children: [
                      // Search bar
                      Container(
                        decoration: ShapeDecoration(
                          color: isDark ? const Color(0xFF1E222A) : const Color(0xFFF3F4F6),
                          shape: AppRadius.continuousMd(),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                        child: TextField(
                          onChanged: (val) => setState(() => _searchQuery = val.trim()),
                          style: AppTypography.bodyMedium.copyWith(
                            color: isDark ? Colors.white : const Color(0xFF111827),
                          ),
                          decoration: InputDecoration(
                            icon: const Icon(Icons.search_rounded, size: 20),
                            border: InputBorder.none,
                            hintText: 'Buscar materias o código...',
                            hintStyle: AppTypography.bodyMedium.copyWith(
                              color: isDark ? const Color(0xFF6B7280) : const Color(0xFF9CA3AF),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      // Filter Chips
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        child: Row(
                          children: [
                            AppChip(
                              label: 'Todas (${subjects.length})',
                              isSelected: _selectedStatusFilter == null,
                              onTap: () => setState(() => _selectedStatusFilter = null),
                            ),
                            ...SubjectStatus.values.map((status) {
                              final count = subjects.where((s) => s.status == status).length;
                              if (count == 0) return const SizedBox.shrink();
                              return Padding(
                                padding: const EdgeInsets.only(left: AppSpacing.sm),
                                child: AppChip(
                                  label: '${status.label} ($count)',
                                  isSelected: _selectedStatusFilter == status,
                                  onTap: () => setState(() => _selectedStatusFilter = status),
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              if (filtered.isEmpty)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: EmptyState(
                    icon: Icons.menu_book_rounded,
                    title: subjects.isEmpty ? AppStrings.noSubjectsYet : 'No se encontraron materias',
                    description: subjects.isEmpty
                        ? AppStrings.noSubjectsDesc
                        : 'Probá ajustando los filtros de búsqueda.',
                    actionLabel: subjects.isEmpty ? AppStrings.newSubject : null,
                    onAction: subjects.isEmpty ? () => UpsertSubjectSheet.show(context) : null,
                  ),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                    vertical: AppSpacing.sm,
                  ),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final s = filtered[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: AppSpacing.md),
                          child: _SubjectCard(subject: s),
                        );
                      },
                      childCount: filtered.length,
                    ),
                  ),
                ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 80),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
      ),
    );
  }
}

class _SubjectCard extends ConsumerWidget {
  final Subject subject;
  const _SubjectCard({required this.subject});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final subjectColor = Color(subject.colorValue);

    return Dismissible(
      key: Key(subject.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: AppSpacing.xl),
        decoration: ShapeDecoration(
          color: const Color(0xFFEF4444),
          shape: AppRadius.continuousLg(),
        ),
        child: const Icon(Icons.delete_outline_rounded, color: Colors.white, size: 24),
      ),
      confirmDismiss: (direction) async {
        final confirmed = await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('¿Eliminar materia?'),
            content: Text('Se ocultará "${subject.name}". Podés deshacer la acción.'),
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
        return confirmed ?? false;
      },
      onDismissed: (_) {
        ref.read(subjectControllerProvider.notifier).deleteSubject(subject.id);
        ScaffoldMessenger.of(context).showSnackBar(
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
      },
      child: AppCard(
        onTap: () => context.push('/subjects/${subject.id}'),
        child: Row(
          children: [
            Hero(
              tag: 'subject_icon_${subject.id}',
              child: Container(
                width: 48,
                height: 48,
                decoration: ShapeDecoration(
                  color: subjectColor.withValues(alpha: isDark ? 0.25 : 0.12),
                  shape: AppRadius.continuousMd(),
                ),
                child: Icon(
                  SubjectIcons.fromCodePoint(subject.iconCode),
                  color: subjectColor,
                  size: 24,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          subject.name,
                          style: AppTypography.titleMedium.copyWith(
                            color: isDark ? Colors.white : const Color(0xFF111827),
                          ),
                          maxLines: 1,
                          overflow: TextTrails.ellipsis,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: ShapeDecoration(
                          color: subjectColor.withValues(alpha: isDark ? 0.2 : 0.1),
                          shape: AppRadius.continuousSm(),
                        ),
                        child: Text(
                          subject.status.label,
                          style: AppTypography.caption.copyWith(
                            color: subjectColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Row(
                    children: [
                      if (subject.code != null) ...[
                        Text(
                          subject.code!,
                          style: AppTypography.caption.copyWith(
                            color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],
                      if (subject.professor != null) ...[
                        Expanded(
                          child: Text(
                            subject.professor!,
                            style: AppTypography.caption.copyWith(
                              color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
                            ),
                            maxLines: 1,
                            overflow: TextTrails.ellipsis,
                          ),
                        ),
                      ],
                      if (subject.classroom != null) ...[
                        const SizedBox(width: 8),
                        Text(
                          subject.classroom!,
                          style: AppTypography.caption.copyWith(
                            color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            Icon(
              Icons.chevron_right_rounded,
              color: isDark ? const Color(0xFF4B5563) : const Color(0xFFD1D5DB),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}

extension TextTrails on TextOverflow {
  static const TextOverflow ellipsis = TextOverflow.ellipsis;
}
