import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/design_system/app_radius.dart';
import '../../../core/design_system/app_spacing.dart';
import '../../../core/design_system/app_typography.dart';
import '../../../core/design_system/components/app_button.dart';
import '../../../core/design_system/components/app_chip.dart';
import '../../../core/design_system/components/app_text_field.dart';
import '../../../core/design_system/components/spring_sheet.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/l10n/app_strings.dart';
import '../../subjects/data/subject_repository.dart';
import '../../exams/data/exam_repository.dart';
import '../../exams/domain/exam.dart';
import '../domain/grade_entry.dart';
import 'grade_controller.dart';

class UpsertGradeSheet extends ConsumerStatefulWidget {
  final GradeEntry? gradeToEdit;
  final String? preselectedSubjectId;
  final String? preselectedExamId;

  const UpsertGradeSheet({
    super.key,
    this.gradeToEdit,
    this.preselectedSubjectId,
    this.preselectedExamId,
  });

  static Future<void> show(
    BuildContext context, {
    GradeEntry? gradeToEdit,
    String? preselectedSubjectId,
    String? preselectedExamId,
  }) {
    return SpringSheet.show(
      context: context,
      title: gradeToEdit == null ? AppStrings.newGrade : 'Editar nota',
      child: UpsertGradeSheet(
        gradeToEdit: gradeToEdit,
        preselectedSubjectId: preselectedSubjectId,
        preselectedExamId: preselectedExamId,
      ),
    );
  }

  @override
  ConsumerState<UpsertGradeSheet> createState() => _UpsertGradeSheetState();
}

class _UpsertGradeSheetState extends ConsumerState<UpsertGradeSheet> {
  late final TextEditingController _titleController;
  late final TextEditingController _valueController;
  late final TextEditingController _weightController;

  String? _selectedSubjectId;
  String? _selectedExamId;
  late GradeKind _kind;
  late DateTime _date;
  bool _isRetake = false;
  bool _replacesOriginal = true;

  String? _valueError;
  String? _titleError;

  @override
  void initState() {
    super.initState();
    final g = widget.gradeToEdit;
    _titleController = TextEditingController(text: g?.title ?? '');
    _valueController = TextEditingController(text: g != null ? g.value.toString() : '');
    _weightController = TextEditingController(text: (g?.weight ?? 1.0).toString());

    _selectedSubjectId = g?.subjectId ?? widget.preselectedSubjectId;
    _selectedExamId = g?.examId ?? widget.preselectedExamId;
    _kind = g?.kind ?? GradeKind.exam;
    _date = g?.date ?? DateTime.now();
    _isRetake = g?.isRetake ?? false;
    _replacesOriginal = g?.replacesOriginal ?? true;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _valueController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() => _date = picked);
    }
  }

  Future<void> _submit() async {
    final val = double.tryParse(_valueController.text.trim().replaceAll(',', '.'));
    bool hasError = false;

    setState(() {
      if (val == null || val < 0) {
        _valueError = 'Ingresá una nota válida';
        hasError = true;
      } else {
        _valueError = null;
      }
      if (_titleController.text.trim().isEmpty) {
        _titleError = 'Ingresá un título descriptivo';
        hasError = true;
      } else {
        _titleError = null;
      }
    });

    if (hasError || _selectedSubjectId == null) return;

    final weight = double.tryParse(_weightController.text.trim().replaceAll(',', '.')) ?? 1.0;

    if (widget.gradeToEdit == null) {
      await ref.read(gradeControllerProvider.notifier).createGrade(
            subjectId: _selectedSubjectId!,
            examId: _selectedExamId,
            title: _titleController.text,
            value: val!,
            weight: weight,
            kind: _kind,
            isRetake: _isRetake,
            replacesOriginal: _replacesOriginal,
            date: _date,
          );
    } else {
      final updated = widget.gradeToEdit!.copyWith(
        subjectId: _selectedSubjectId!,
        examId: _selectedExamId,
        title: _titleController.text.trim(),
        value: val!,
        weight: weight,
        kind: _kind,
        isRetake: _isRetake,
        replacesOriginal: _replacesOriginal,
        date: _date,
      );
      await ref.read(gradeControllerProvider.notifier).updateGrade(updated);
    }

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final subjectsAsync = ref.watch(subjectsStreamProvider);
    final examsAsync = ref.watch(examsStreamProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Subject Selector
        subjectsAsync.when(
          data: (subjects) {
            if (_selectedSubjectId == null && subjects.isNotEmpty) {
              _selectedSubjectId = subjects.first.id;
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Materia', style: AppTypography.titleSmall),
                const SizedBox(height: AppSpacing.xs),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                  decoration: ShapeDecoration(
                    color: isDark ? const Color(0xFF1E222A) : const Color(0xFFF9FAFB),
                    shape: AppRadius.continuousMd(
                      side: BorderSide(
                        color: isDark ? const Color(0xFF2A2E37) : const Color(0xFFE5E7EB),
                      ),
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedSubjectId,
                      isExpanded: true,
                      dropdownColor: isDark ? const Color(0xFF1E222A) : Colors.white,
                      items: subjects.map((s) {
                        return DropdownMenuItem<String>(
                          value: s.id,
                          child: Text(s.name),
                        );
                      }).toList(),
                      onChanged: (val) => setState(() {
                        _selectedSubjectId = val;
                        _selectedExamId = null;
                      }),
                    ),
                  ),
                ),
              ],
            );
          },
          loading: () => const SizedBox.shrink(),
          error: (_, __) => const SizedBox.shrink(),
        ),
        const SizedBox(height: AppSpacing.md),

        // Optional Exam Selector
        examsAsync.when(
          data: (allExams) {
            final availableExams = allExams.where((e) => e.subjectId == _selectedSubjectId).toList();
            if (availableExams.isEmpty) return const SizedBox.shrink();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Vincular a examen (opcional)', style: AppTypography.titleSmall),
                const SizedBox(height: AppSpacing.xs),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                  decoration: ShapeDecoration(
                    color: isDark ? const Color(0xFF1E222A) : const Color(0xFFF9FAFB),
                    shape: AppRadius.continuousMd(
                      side: BorderSide(
                        color: isDark ? const Color(0xFF2A2E37) : const Color(0xFFE5E7EB),
                      ),
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String?>(
                      value: _selectedExamId,
                      isExpanded: true,
                      dropdownColor: isDark ? const Color(0xFF1E222A) : Colors.white,
                      hint: const Text('Nota independiente'),
                      items: [
                        const DropdownMenuItem<String?>(
                          value: null,
                          child: Text('Nota independiente (sin examen vinculado)'),
                        ),
                        ...availableExams.map((e) => DropdownMenuItem<String?>(
                              value: e.id,
                              child: Text('${e.type.label}: ${e.title}'),
                            )),
                      ],
                      onChanged: (val) {
                        setState(() {
                          _selectedExamId = val;
                          if (val != null && _titleController.text.isEmpty) {
                            final exam = availableExams.firstWhere((e) => e.id == val);
                            _titleController.text = exam.title;
                            if (exam.type == ExamType.retake) {
                              _isRetake = true;
                            }
                          }
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
              ],
            );
          },
          loading: () => const SizedBox.shrink(),
          error: (_, __) => const SizedBox.shrink(),
        ),

        // Kind selector chips
        Text('Tipo de calificación', style: AppTypography.titleSmall),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: GradeKind.values.map((k) {
            return Padding(
              padding: const EdgeInsets.only(right: AppSpacing.sm),
              child: AppChip(
                label: k.label,
                isSelected: k == _kind,
                onTap: () => setState(() => _kind = k),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: AppSpacing.md),

        AppTextField(
          controller: _titleController,
          label: 'Título de la nota',
          hint: 'Ej. 1er Parcial / TP 2',
          errorText: _titleError,
          onChanged: (v) {
            if (_titleError != null && v.trim().isNotEmpty) {
              setState(() => _titleError = null);
            }
          },
        ),
        const SizedBox(height: AppSpacing.md),

        Row(
          children: [
            Expanded(
              child: AppTextField(
                controller: _valueController,
                label: AppStrings.gradeValue,
                hint: 'Ej. 8.5',
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                errorText: _valueError,
                prefixIcon: const Icon(Icons.star_outline_rounded, size: 20),
                onChanged: (v) {
                  if (_valueError != null && v.trim().isNotEmpty) {
                    setState(() => _valueError = null);
                  }
                },
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: AppTextField(
                controller: _weightController,
                label: 'Ponderación (peso)',
                hint: '1.0',
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                prefixIcon: const Icon(Icons.scale_outlined, size: 20),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),

        // Date selector
        GestureDetector(
          onTap: _pickDate,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: 14),
            decoration: ShapeDecoration(
              color: isDark ? const Color(0xFF1E222A) : const Color(0xFFF9FAFB),
              shape: AppRadius.continuousMd(
                side: BorderSide(
                  color: isDark ? const Color(0xFF2A2E37) : const Color(0xFFE5E7EB),
                ),
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.calendar_today_rounded, size: 18, color: Colors.grey),
                const SizedBox(width: AppSpacing.sm),
                Text('Fecha: ${AppFormatters.date(_date)}', style: AppTypography.bodyMedium),
              ],
            ),
          ),
        ),

        // Retake options
        CheckboxListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Es recuperatorio', style: AppTypography.titleSmall),
          value: _isRetake,
          onChanged: (val) => setState(() => _isRetake = val ?? false),
        ),
        if (_isRetake) ...[
          RadioGroup<bool>(
            groupValue: _replacesOriginal,
            onChanged: (val) => setState(() => _replacesOriginal = val ?? true),
            child: Column(
              children: [
                RadioListTile<bool>(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Reemplaza la nota original', style: AppTypography.bodyMedium),
                  value: true,
                ),
                RadioListTile<bool>(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Se promedia con la nota original', style: AppTypography.bodyMedium),
                  value: false,
                ),
              ],
            ),
          ),
        ],
        const SizedBox(height: AppSpacing.xl),

        AppButton(
          label: widget.gradeToEdit == null ? 'Registrar nota' : AppStrings.save,
          onPressed: _submit,
          isExpanded: true,
          height: 48,
        ),
        const SizedBox(height: AppSpacing.md),
      ],
    );
  }
}
