import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/design_system/app_radius.dart';
import '../../../core/design_system/app_spacing.dart';
import '../../../core/design_system/app_typography.dart';
import '../../../core/design_system/components/app_card.dart';
import '../../../core/design_system/components/app_text_field.dart';
import '../../../core/design_system/components/spring_sheet.dart';
import '../../../core/l10n/app_strings.dart';
import '../../subjects/data/subject_repository.dart';
import '../data/grade_repository.dart';
import 'grade_controller.dart';

class GradeCalculatorSheet extends ConsumerStatefulWidget {
  const GradeCalculatorSheet({super.key});

  static Future<void> show(BuildContext context) {
    return SpringSheet.show(
      context: context,
      title: AppStrings.calculatorTitle,
      child: const GradeCalculatorSheet(),
    );
  }

  @override
  ConsumerState<GradeCalculatorSheet> createState() => _GradeCalculatorSheetState();
}

class _GradeCalculatorSheetState extends ConsumerState<GradeCalculatorSheet> {
  String? _selectedSubjectId;
  final _targetController = TextEditingController(text: '7.0');
  final _weightController = TextEditingController(text: '1.0');
  double? _requiredGrade;

  @override
  void dispose() {
    _targetController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  void _calculate() {
    if (_selectedSubjectId == null) return;
    final allGrades = ref.read(allGradesStreamProvider).value ?? [];
    final subjectGrades = allGrades.where((g) => g.subjectId == _selectedSubjectId).toList();

    final target = double.tryParse(_targetController.text.trim().replaceAll(',', '.')) ?? 7.0;
    final weight = double.tryParse(_weightController.text.trim().replaceAll(',', '.')) ?? 1.0;

    final result = GradeCalculations.calculateRequiredGrade(
      currentGrades: subjectGrades,
      targetAverage: target,
      remainingWeight: weight,
    );

    setState(() {
      _requiredGrade = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final subjectsAsync = ref.watch(subjectsStreamProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Calculá qué calificación necesitás en tu próximo examen o entrega para alcanzar tu meta académica.',
          style: AppTypography.bodyMedium.copyWith(
            color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),

        // Subject selector
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
                      items: subjects.map((s) => DropdownMenuItem(value: s.id, child: Text(s.name))).toList(),
                      onChanged: (val) {
                        setState(() {
                          _selectedSubjectId = val;
                          _requiredGrade = null;
                        });
                      },
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

        Row(
          children: [
            Expanded(
              child: AppTextField(
                controller: _targetController,
                label: 'Promedio deseado',
                hint: '7.0',
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onChanged: (_) => _calculate(),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: AppTextField(
                controller: _weightController,
                label: 'Peso del examen',
                hint: '1.0',
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onChanged: (_) => _calculate(),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xl),

        // Result Card
        if (_requiredGrade != null) ...[
          AppCard(
            color: _requiredGrade! <= 10.0
                ? Colors.green.withValues(alpha: isDark ? 0.2 : 0.1)
                : Colors.red.withValues(alpha: isDark ? 0.2 : 0.1),
            child: Column(
              children: [
                Text(
                  _requiredGrade! <= 10.0
                      ? 'Nota necesaria para llegar al objetivo'
                      : '¡Meta inalcanzable con ese peso!',
                  textAlign: TextAlign.center,
                  style: AppTypography.titleSmall.copyWith(
                    color: _requiredGrade! <= 10.0 ? Colors.green : Colors.red,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  _requiredGrade! < 0 ? '0' : _requiredGrade!.toStringAsFixed(2),
                  style: AppTypography.display.copyWith(
                    color: _requiredGrade! <= 10.0 ? Colors.green : Colors.red,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  _requiredGrade! <= 4.0
                      ? 'Con una nota regular ya cumplís la meta.'
                      : (_requiredGrade! <= 10.0
                          ? 'Necesitás obtener esta calificación en la próxima evaluación.'
                          : 'Aun sacando 10 no alcanza para ese promedio objetivo con esa ponderación.'),
                  textAlign: TextAlign.center,
                  style: AppTypography.caption.copyWith(color: Colors.grey),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
        ],

        ElevatedButton(
          onPressed: _calculate,
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.colorScheme.primary,
            foregroundColor: Colors.white,
            minimumSize: const Size.fromHeight(48),
            shape: AppRadius.continuousMd(),
          ),
          child: const Text('Calcular nota necesaria'),
        ),
        const SizedBox(height: AppSpacing.md),
      ],
    );
  }
}
