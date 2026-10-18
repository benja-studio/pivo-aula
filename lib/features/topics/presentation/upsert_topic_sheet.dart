import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/design_system/app_spacing.dart';
import '../../../core/design_system/app_typography.dart';
import '../../../core/design_system/components/app_button.dart';
import '../../../core/design_system/components/app_chip.dart';
import '../../../core/design_system/components/app_text_field.dart';
import '../../../core/design_system/components/spring_sheet.dart';
import '../../../core/l10n/app_strings.dart';
import '../domain/topic.dart';
import 'topic_controller.dart';

class UpsertTopicSheet extends ConsumerStatefulWidget {
  final String subjectId;
  final String? examId;
  final Topic? topicToEdit;

  const UpsertTopicSheet({
    super.key,
    required this.subjectId,
    this.examId,
    this.topicToEdit,
  });

  static Future<void> show(
    BuildContext context, {
    required String subjectId,
    String? examId,
    Topic? topicToEdit,
  }) {
    return SpringSheet.show(
      context: context,
      title: topicToEdit == null ? AppStrings.addTopic : 'Editar tema',
      child: UpsertTopicSheet(
        subjectId: subjectId,
        examId: examId,
        topicToEdit: topicToEdit,
      ),
    );
  }

  @override
  ConsumerState<UpsertTopicSheet> createState() => _UpsertTopicSheetState();
}

class _UpsertTopicSheetState extends ConsumerState<UpsertTopicSheet> {
  late final TextEditingController _titleController;
  late final TextEditingController _notesController;
  late TopicStatus _status;
  late TopicPriority _priority;
  String? _titleError;

  @override
  void initState() {
    super.initState();
    final t = widget.topicToEdit;
    _titleController = TextEditingController(text: t?.title ?? '');
    _notesController = TextEditingController(text: t?.notes ?? '');
    _status = t?.status ?? TopicStatus.todo;
    _priority = t?.priority ?? TopicPriority.medium;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_titleController.text.trim().isEmpty) {
      setState(() => _titleError = 'Ingresá el título del tema');
      return;
    }

    if (widget.topicToEdit == null) {
      await ref.read(topicControllerProvider.notifier).createTopic(
            subjectId: widget.subjectId,
            examId: widget.examId,
            title: _titleController.text,
            status: _status,
            priority: _priority,
            notes: _notesController.text,
          );
    } else {
      final updated = widget.topicToEdit!.copyWith(
        title: _titleController.text.trim(),
        status: _status,
        priority: _priority,
        notes: _notesController.text.trim().isEmpty ? null : _notesController.text.trim(),
      );
      await ref.read(topicControllerProvider.notifier).updateTopic(updated);
    }

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        AppTextField(
          controller: _titleController,
          label: 'Título del tema',
          hint: 'Ej. Grafos y Algoritmo de Dijkstra',
          errorText: _titleError,
          autofocus: true,
          onChanged: (v) {
            if (_titleError != null && v.trim().isNotEmpty) {
              setState(() => _titleError = null);
            }
          },
        ),
        const SizedBox(height: AppSpacing.md),

        // Status
        Text('Estado de estudio', style: AppTypography.titleSmall),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: TopicStatus.values.map((s) {
            return AppChip(
              label: s.label,
              isSelected: s == _status,
              onTap: () => setState(() => _status = s),
            );
          }).toList(),
        ),
        const SizedBox(height: AppSpacing.md),

        // Priority
        Text('Prioridad', style: AppTypography.titleSmall),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: TopicPriority.values.map((p) {
            return Padding(
              padding: const EdgeInsets.only(right: AppSpacing.sm),
              child: AppChip(
                label: p.label,
                isSelected: p == _priority,
                onTap: () => setState(() => _priority = p),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: AppSpacing.md),

        AppTextField(
          controller: _notesController,
          label: 'Notas de estudio (opcional)',
          hint: 'Ej. Repasar ejercicio 4 de la guía práctica...',
          maxLines: 2,
        ),
        const SizedBox(height: AppSpacing.xl),

        AppButton(
          label: widget.topicToEdit == null ? 'Agregar tema' : AppStrings.save,
          onPressed: _submit,
          isExpanded: true,
          height: 48,
        ),
        const SizedBox(height: AppSpacing.md),
      ],
    );
  }
}
