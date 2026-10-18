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
import '../data/exam_repository.dart';
import '../domain/exam.dart';
import 'exam_controller.dart';

class UpsertExamSheet extends ConsumerStatefulWidget {
  final Exam? examToEdit;
  final String? preselectedSubjectId;

  const UpsertExamSheet({
    super.key,
    this.examToEdit,
    this.preselectedSubjectId,
  });

  static Future<void> show(
    BuildContext context, {
    Exam? examToEdit,
    String? preselectedSubjectId,
  }) {
    return SpringSheet.show(
      context: context,
      title: examToEdit == null ? AppStrings.newExam : AppStrings.editExam,
      child: UpsertExamSheet(
        examToEdit: examToEdit,
        preselectedSubjectId: preselectedSubjectId,
      ),
    );
  }

  @override
  ConsumerState<UpsertExamSheet> createState() => _UpsertExamSheetState();
}

class _UpsertExamSheetState extends ConsumerState<UpsertExamSheet> {
  late final TextEditingController _titleController;
  late final TextEditingController _classroomController;
  late final TextEditingController _durationController;

  String? _selectedSubjectId;
  late ExamType _selectedType;
  late ExamStatus _selectedStatus;
  late DateTime _selectedDateTime;
  String? _retakeOfExamId;
  bool _remindersEnabled = true;

  String? _titleError;
  String? _subjectError;

  @override
  void initState() {
    super.initState();
    final e = widget.examToEdit;
    _titleController = TextEditingController(text: e?.title ?? '');
    _classroomController = TextEditingController(text: e?.classroom ?? '');
    _durationController = TextEditingController(text: (e?.durationMinutes ?? 120).toString());

    _selectedSubjectId = e?.subjectId ?? widget.preselectedSubjectId;
    _selectedType = e?.type ?? ExamType.midterm;
    _selectedStatus = e?.status ?? ExamStatus.pending;
    _selectedDateTime = e?.dateTime ?? DateTime.now().add(const Duration(days: 7));
    _retakeOfExamId = e?.retakeOfExamId;
    _remindersEnabled = e?.remindersEnabled ?? true;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _classroomController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  bool _detectConflict(List<Exam> allExams) {
    for (final other in allExams) {
      if (widget.examToEdit != null && other.id == widget.examToEdit!.id) {
        continue;
      }
      final diff = other.dateTime.difference(_selectedDateTime).inMinutes.abs();
      if (diff < (other.durationMinutes.clamp(60, 240))) {
        return true;
      }
    }
    return false;
  }

  Future<void> _pickDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
    );
    if (date == null) return;

    if (!mounted) return;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_selectedDateTime),
    );
    if (time == null) return;

    setState(() {
      _selectedDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  Future<void> _submit() async {
    bool hasError = false;
    setState(() {
      if (_titleController.text.trim().isEmpty) {
        _titleError = 'Ingresá el título o descripción';
        hasError = true;
      } else {
        _titleError = null;
      }
      if (_selectedSubjectId == null) {
        _subjectError = 'Seleccioná una materia';
        hasError = true;
      } else {
        _subjectError = null;
      }
    });
    if (hasError) return;

    final duration = int.tryParse(_durationController.text.trim()) ?? 120;

    if (widget.examToEdit == null) {
      await ref.read(examControllerProvider.notifier).createExam(
            subjectId: _selectedSubjectId!,
            type: _selectedType,
            title: _titleController.text,
            dateTime: _selectedDateTime,
            durationMinutes: duration,
            classroom: _classroomController.text,
            retakeOfExamId: _selectedType == ExamType.retake ? _retakeOfExamId : null,
            status: _selectedStatus,
            remindersEnabled: _remindersEnabled,
          );
    } else {
      final updated = widget.examToEdit!.copyWith(
        subjectId: _selectedSubjectId!,
        type: _selectedType,
        title: _titleController.text.trim(),
        dateTime: _selectedDateTime,
        durationMinutes: duration,
        classroom: _classroomController.text.trim().isEmpty ? null : _classroomController.text.trim(),
        retakeOfExamId: _selectedType == ExamType.retake ? _retakeOfExamId : null,
        status: _selectedStatus,
        remindersEnabled: _remindersEnabled,
      );
      await ref.read(examControllerProvider.notifier).updateExam(updated);
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
    final allExamsAsync = ref.watch(examsStreamProvider);

    final allExams = allExamsAsync.value ?? [];
    final hasConflict = _detectConflict(allExams);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Subject Dropdown
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
                        color: _subjectError != null
                            ? Colors.red
                            : (isDark ? const Color(0xFF2A2E37) : const Color(0xFFE5E7EB)),
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
                          child: Row(
                            children: [
                              Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: Color(s.colorValue),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: AppSpacing.sm),
                              Text(s.name),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (val) => setState(() => _selectedSubjectId = val),
                    ),
                  ),
                ),
                if (_subjectError != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(_subjectError!, style: const TextStyle(color: Colors.red, fontSize: 12)),
                  ),
              ],
            );
          },
          loading: () => const SizedBox.shrink(),
          error: (_, __) => const SizedBox.shrink(),
        ),
        const SizedBox(height: AppSpacing.md),

        // Exam Type Chips
        Text(AppStrings.examType, style: AppTypography.titleSmall),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: ExamType.values.map((type) {
            final isSelected = type == _selectedType;
            return AppChip(
              label: type.label,
              isSelected: isSelected,
              onTap: () => setState(() => _selectedType = type),
            );
          }).toList(),
        ),
        const SizedBox(height: AppSpacing.md),

        // If retake: select which midterm it recovers
        if (_selectedType == ExamType.retake) ...[
          Text(AppStrings.retakeOf, style: AppTypography.titleSmall),
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
                value: _retakeOfExamId,
                isExpanded: true,
                dropdownColor: isDark ? const Color(0xFF1E222A) : Colors.white,
                hint: const Text('Seleccionar examen original'),
                items: [
                  const DropdownMenuItem<String?>(
                    value: null,
                    child: Text('Ninguno (independiente)'),
                  ),
                  ...allExams
                      .where((e) =>
                          e.subjectId == _selectedSubjectId &&
                          e.type == ExamType.midterm &&
                          e.id != widget.examToEdit?.id)
                      .map((e) => DropdownMenuItem<String?>(
                            value: e.id,
                            child: Text(e.title),
                          )),
                ],
                onChanged: (val) => setState(() => _retakeOfExamId = val),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
        ],

        AppTextField(
          controller: _titleController,
          label: AppStrings.examTitle,
          hint: 'Ej. 1er Parcial - Teórico y Práctico',
          errorText: _titleError,
          prefixIcon: const Icon(Icons.edit_note_rounded, size: 20),
          onChanged: (v) {
            if (_titleError != null && v.trim().isNotEmpty) {
              setState(() => _titleError = null);
            }
          },
        ),
        const SizedBox(height: AppSpacing.md),

        // Date and Time selector
        Text(AppStrings.examDate, style: AppTypography.titleSmall),
        const SizedBox(height: AppSpacing.xs),
        GestureDetector(
          onTap: _pickDateTime,
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
                const Icon(Icons.calendar_month_rounded, size: 20, color: Colors.grey),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  '${AppFormatters.date(_selectedDateTime)} · ${AppFormatters.time(_selectedDateTime)} hs',
                  style: AppTypography.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                Text(
                  AppFormatters.countdown(_selectedDateTime),
                  style: AppTypography.caption.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),

        // Conflict Warning banner
        if (hasConflict) ...[
          const SizedBox(height: AppSpacing.sm),
          Container(
            padding: const EdgeInsets.all(AppSpacing.sm + 2),
            decoration: ShapeDecoration(
              color: Colors.amber.withValues(alpha: isDark ? 0.2 : 0.12),
              shape: AppRadius.continuousSm(
                side: BorderSide(color: Colors.amber.withValues(alpha: 0.6)),
              ),
            ),
            child: const Row(
              children: [
                Icon(Icons.warning_amber_rounded, color: Colors.amber, size: 18),
                SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: Text(
                    AppStrings.conflictWarning,
                    style: TextStyle(color: Colors.amber, fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        ],

        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Expanded(
              child: AppTextField(
                controller: _durationController,
                label: AppStrings.duration,
                hint: '120',
                keyboardType: TextInputType.number,
                prefixIcon: const Icon(Icons.timer_outlined, size: 20),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: AppTextField(
                controller: _classroomController,
                label: 'Aula / Lugar',
                hint: 'Ej. Aula 204',
                prefixIcon: const Icon(Icons.room_outlined, size: 20),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),

        // Status Selection
        Text(AppStrings.status, style: AppTypography.titleSmall),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: ExamStatus.values.map((status) {
            final isSelected = status == _selectedStatus;
            return AppChip(
              label: status.label,
              isSelected: isSelected,
              onTap: () => setState(() => _selectedStatus = status),
            );
          }).toList(),
        ),
        const SizedBox(height: AppSpacing.md),

        // Reminders switch
        SwitchListTile.adaptive(
          contentPadding: EdgeInsets.zero,
          value: _remindersEnabled,
          activeThumbColor: theme.colorScheme.primary,
          activeTrackColor: theme.colorScheme.primary.withValues(alpha: 0.5),
          title: const Text('Recordatorio para este examen', style: AppTypography.titleSmall),
          subtitle: const Text('Notificación 1 día antes y la mañana del evento', style: AppTypography.caption),
          onChanged: (val) => setState(() => _remindersEnabled = val),
        ),
        const SizedBox(height: AppSpacing.xl),

        AppButton(
          label: widget.examToEdit == null ? 'Crear examen' : AppStrings.save,
          onPressed: _submit,
          isExpanded: true,
          height: 48,
        ),
        const SizedBox(height: AppSpacing.md),
      ],
    );
  }
}
