import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/design_system/app_colors.dart';
import '../../../core/design_system/app_radius.dart';
import '../../../core/design_system/app_spacing.dart';
import '../../../core/design_system/app_typography.dart';
import '../../../core/design_system/components/app_button.dart';
import '../../../core/design_system/components/app_chip.dart';
import '../../../core/design_system/components/app_text_field.dart';
import '../../../core/design_system/components/spring_sheet.dart';
import '../../../core/l10n/app_strings.dart';
import '../../profile/data/profile_repository.dart';
import '../domain/subject.dart';
import '../domain/subject_icons.dart';
import 'subject_controller.dart';
import 'subject_form_preferences.dart';

class UpsertSubjectSheet extends ConsumerStatefulWidget {
  final Subject? subjectToEdit;

  const UpsertSubjectSheet({super.key, this.subjectToEdit});

  static Future<void> show(BuildContext context, {Subject? subjectToEdit}) {
    return SpringSheet.show(
      context: context,
      title: subjectToEdit == null ? AppStrings.newSubject : AppStrings.editSubject,
      child: UpsertSubjectSheet(subjectToEdit: subjectToEdit),
    );
  }

  @override
  ConsumerState<UpsertSubjectSheet> createState() => _UpsertSubjectSheetState();
}

class _UpsertSubjectSheetState extends ConsumerState<UpsertSubjectSheet> {
  late final TextEditingController _nameController;
  late final TextEditingController _codeController;
  late final TextEditingController _professorController;
  late final TextEditingController _classroomController;
  late final TextEditingController _creditsController;
  late final TextEditingController _notesController;

  late int _selectedColor;
  late int _selectedIcon;
  late SubjectStatus _selectedStatus;
  late double _passingGrade;
  String? _nameError;
  bool _showAdvancedFields = false;
  bool _isSaving = false;
  String? _saveError;

  @override
  void initState() {
    super.initState();
    final s = widget.subjectToEdit;
    _nameController = TextEditingController(text: s?.name ?? '');
    _codeController = TextEditingController(text: s?.code ?? '');
    _professorController = TextEditingController(text: s?.professor ?? '');
    _classroomController = TextEditingController(text: s?.classroom ?? '');
    _creditsController = TextEditingController(text: s?.credits?.toString() ?? '');
    _notesController = TextEditingController(text: s?.notes ?? '');

    _selectedColor = s?.colorValue ?? AppColors.subjectColors.first.toARGB32();
    _selectedIcon = s?.iconCode ?? SubjectIcons.available.first.codePoint;
    _selectedStatus = s?.status ?? SubjectStatus.enrolled;
    _passingGrade = s?.passingGrade ?? 4.0;
    _showAdvancedFields = s != null;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _codeController.dispose();
    _professorController.dispose();
    _classroomController.dispose();
    _creditsController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_isSaving) return;
    if (_nameController.text.trim().isEmpty) {
      setState(() => _nameError = 'Ingresá el nombre de la materia');
      return;
    }

    setState(() {
      _isSaving = true;
      _saveError = null;
    });
    try {
      final profile = await ref.read(profileRepositoryProvider).getProfile();
      final period = profile?.currentPeriod ?? '1er Cuatrimestre';
      final credits = int.tryParse(_creditsController.text.trim());

      if (widget.subjectToEdit == null) {
        await ref.read(subjectControllerProvider.notifier).createSubject(
          name: _nameController.text,
          code: _codeController.text,
          colorValue: _selectedColor,
          iconCode: _selectedIcon,
          professor: _professorController.text,
          classroom: _classroomController.text,
          credits: credits,
          status: _selectedStatus,
          period: period,
          passingGrade: _passingGrade,
          notes: _notesController.text,
        );
      } else {
        final original = widget.subjectToEdit!;
        final updated = original.copyWith(
          name: _nameController.text.trim(),
          code: _codeController.text.trim().isEmpty ? null : _codeController.text.trim(),
          colorValue: _selectedColor,
          iconCode: _selectedIcon,
          professor: _professorController.text.trim().isEmpty ? null : _professorController.text.trim(),
          classroom: _classroomController.text.trim().isEmpty ? null : _classroomController.text.trim(),
          credits: credits,
          status: _selectedStatus,
          passingGrade: _passingGrade,
          notes: _notesController.text.trim().isEmpty ? null : _notesController.text.trim(),
        );
        await ref.read(subjectControllerProvider.notifier).updateSubject(updated);
      }

      final result = ref.read(subjectControllerProvider);
      if (result.hasError) {
        throw result.error ?? Exception('No se pudo guardar la materia.');
      }
      if (mounted) Navigator.of(context).pop();
    } catch (error) {
      if (mounted) {
        setState(() => _saveError = 'No se pudo guardar. Revisá los datos e intentá otra vez.');
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final preferences = ref.watch(subjectFormPreferencesProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        AppTextField(
          controller: _nameController,
          label: AppStrings.subjectName,
          hint: 'Ej. Algoritmos y Estructuras de Datos',
          errorText: _nameError,
          prefixIcon: const Icon(Icons.bookmark_outline_rounded, size: 20),
          onChanged: (v) {
            if (_nameError != null && v.trim().isNotEmpty) {
              setState(() => _nameError = null);
            }
          },
        ),
        if (_showAdvancedFields) ...[
          const SizedBox(height: AppSpacing.md),
          if (preferences.showCodeField && preferences.showCreditsField)
            Row(
              children: [
                Expanded(child: AppTextField(controller: _codeController, label: AppStrings.subjectCode, hint: 'Ej. AED-301')),
                const SizedBox(width: AppSpacing.md),
                Expanded(child: AppTextField(controller: _creditsController, label: AppStrings.credits, hint: 'Ej. 6', keyboardType: TextInputType.number)),
              ],
            )
          else if (preferences.showCodeField)
            AppTextField(controller: _codeController, label: AppStrings.subjectCode, hint: 'Ej. AED-301')
          else if (preferences.showCreditsField)
            AppTextField(controller: _creditsController, label: AppStrings.credits, hint: 'Ej. 6', keyboardType: TextInputType.number),
          if (preferences.showCodeField || preferences.showCreditsField)
            const SizedBox(height: AppSpacing.md),
          if (preferences.showProfessorField && preferences.showClassroomField)
            Row(
              children: [
                Expanded(child: AppTextField(controller: _professorController, label: AppStrings.professor, hint: 'Ej. Ing. Rossi', prefixIcon: const Icon(Icons.person_outline_rounded, size: 20))),
                const SizedBox(width: AppSpacing.md),
                Expanded(child: AppTextField(controller: _classroomController, label: AppStrings.classroom, hint: 'Ej. Aula 402 / Virtual', prefixIcon: const Icon(Icons.room_outlined, size: 20))),
              ],
            )
          else if (preferences.showProfessorField)
            AppTextField(controller: _professorController, label: AppStrings.professor, hint: 'Ej. Ing. Rossi', prefixIcon: const Icon(Icons.person_outline_rounded, size: 20))
          else if (preferences.showClassroomField)
            AppTextField(controller: _classroomController, label: AppStrings.classroom, hint: 'Ej. Aula 402 / Virtual', prefixIcon: const Icon(Icons.room_outlined, size: 20)),
          if (preferences.showProfessorField || preferences.showClassroomField)
            const SizedBox(height: AppSpacing.lg),
          if (preferences.showColorPicker) ...[
            Text('Color de la materia', style: AppTypography.titleSmall),
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: AppColors.subjectColors.map((color) {
                final isSelected = color.toARGB32() == _selectedColor;
                return Semantics(
                  button: true,
                  selected: isSelected,
                  label: 'Seleccionar color de materia',
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => setState(() => _selectedColor = color.toARGB32()),
                    child: SizedBox(
                      width: 48,
                      height: 48,
                      child: Center(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 160),
                          width: isSelected ? 42 : 36,
                          height: isSelected ? 42 : 36,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected ? (isDark ? Colors.white : const Color(0xFF111827)) : Colors.transparent,
                              width: 2,
                            ),
                            boxShadow: [
                              if (isSelected)
                                BoxShadow(color: color.withValues(alpha: 0.35), blurRadius: 8, offset: const Offset(0, 2)),
                            ],
                          ),
                          child: isSelected ? const Icon(Icons.check_rounded, color: Colors.white, size: 19) : null,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: AppSpacing.lg),
          ],
          if (preferences.showIconPicker) ...[
            Text('Ícono representativo', style: AppTypography.titleSmall),
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: SubjectIcons.available.map((icon) {
                final isSelected = icon.codePoint == _selectedIcon;
                return Semantics(
                  button: true,
                  selected: isSelected,
                  label: isSelected ? 'Ícono seleccionado' : 'Seleccionar ícono',
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => setState(() => _selectedIcon = icon.codePoint),
                    child: SizedBox(
                      width: 48,
                      height: 48,
                      child: Center(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 160),
                          width: 44,
                          height: 44,
                          decoration: ShapeDecoration(
                            color: isSelected ? Color(_selectedColor).withValues(alpha: isDark ? 0.3 : 0.12) : (isDark ? const Color(0xFF22262E) : const Color(0xFFF3F4F6)),
                            shape: AppRadius.continuousSm(
                              side: isSelected ? BorderSide(color: Color(_selectedColor), width: 1.6) : BorderSide(color: isDark ? const Color(0xFF343A46) : const Color(0xFFE5E7EB)),
                            ),
                          ),
                          child: Icon(icon, size: 21, color: isSelected ? Color(_selectedColor) : Colors.grey),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: AppSpacing.lg),
          ],
          if (preferences.showStatusSelector) ...[
            Text(AppStrings.status, style: AppTypography.titleSmall),
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: SubjectStatus.values.map((status) {
                final isSelected = status == _selectedStatus;
                return AppChip(label: status.label, isSelected: isSelected, activeColor: Color(_selectedColor), onTap: () => setState(() => _selectedStatus = status));
              }).toList(),
            ),
            const SizedBox(height: AppSpacing.md),
          ],
          if (preferences.showPassingGrade) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(AppStrings.passingGrade, style: AppTypography.titleSmall),
                Text(_passingGrade.toStringAsFixed(1), style: AppTypography.titleMedium.copyWith(color: Color(_selectedColor))),
              ],
            ),
            Slider(value: _passingGrade, min: 1, max: 10, divisions: 18, activeColor: Color(_selectedColor), onChanged: (value) => setState(() => _passingGrade = value)),
            const SizedBox(height: AppSpacing.md),
          ],
          if (preferences.showNotesField)
            AppTextField(controller: _notesController, label: 'Notas o comentarios', hint: 'Ej. Criterio de promoción: 2 parciales con 7 o más...', maxLines: 3),
          if (preferences.showNotesField)
            const SizedBox(height: AppSpacing.xl)
          else
            const SizedBox(height: AppSpacing.md),
        ] else ...[
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Con el nombre alcanza para crearla. Podés configurar los demás detalles después.',
            style: AppTypography.caption.copyWith(color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280)),
          ),
          const SizedBox(height: AppSpacing.sm),
          AppButton(
            label: 'Más opciones (opcional)',
            icon: Icons.tune_rounded,
            variant: AppButtonVariant.secondary,
            onPressed: () => setState(() => _showAdvancedFields = true),
            isExpanded: true,
          ),
          const SizedBox(height: AppSpacing.md),
        ],
        if (_saveError != null) ...[
          Text(_saveError!, style: AppTypography.caption.copyWith(color: theme.colorScheme.error)),
          const SizedBox(height: AppSpacing.sm),
        ],
        AppButton(
          label: widget.subjectToEdit == null ? 'Crear materia' : AppStrings.save,
          onPressed: _isSaving ? null : _submit,
          isLoading: _isSaving,
          isExpanded: true,
          height: 48,
        ),
        const SizedBox(height: AppSpacing.md),
      ],
    );
  }
}
