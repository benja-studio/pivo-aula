import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/design_system/app_radius.dart';
import '../../../core/design_system/app_scroll_physics.dart';
import '../../../core/design_system/app_spacing.dart';
import '../../../core/design_system/app_typography.dart';
import '../../../core/design_system/components/app_card.dart';
import '../../../core/design_system/components/app_chip.dart';
import '../../../core/design_system/components/empty_state.dart';
import '../../../core/design_system/components/spring_sheet.dart';
import '../../../core/utils/formatters.dart';
import '../../exams/data/exam_repository.dart';
import '../../exams/domain/exam.dart';
import '../../exams/presentation/upsert_exam_sheet.dart';
import '../../subjects/data/subject_repository.dart';

class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  DateTime _currentMonth = DateTime(DateTime.now().year, DateTime.now().month, 1);
  DateTime _selectedDay = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  String? _selectedSubjectFilter;
  ExamType? _selectedTypeFilter;

  void _changeMonth(int delta) {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + delta, 1);
    });
  }

  void _showEventsForDay(DateTime day, List<Exam> dayExams, dynamic subjects) {
    SpringSheet.show(
      context: context,
      title: 'Eventos del ${AppFormatters.date(day)}',
      child: dayExams.isEmpty
          ? const Padding(
              padding: EdgeInsets.all(AppSpacing.xl),
              child: Text('No hay evaluaciones programadas para este día.'),
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: dayExams.map((e) {
                final sub = subjects.where((s) => s.id == e.subjectId).firstOrNull;
                return Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: AppCard(
                    onTap: () {
                      Navigator.pop(context);
                      context.push('/exams/${e.id}');
                    },
                    child: ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      title: Text(e.title, style: AppTypography.titleSmall),
                      subtitle: Text(
                        '${sub?.name ?? ''} · ${AppFormatters.time(e.dateTime)} hs · ${e.type.label}',
                      ),
                      trailing: const Icon(Icons.chevron_right_rounded),
                    ),
                  ),
                );
              }).toList(),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final examsAsync = ref.watch(examsStreamProvider);
    final subjectsAsync = ref.watch(subjectsStreamProvider);

    final allExams = examsAsync.value ?? [];
    final allSubjects = subjectsAsync.value ?? [];

    final filteredExams = allExams.where((e) {
      final matchesSubject = _selectedSubjectFilter == null || e.subjectId == _selectedSubjectFilter;
      final matchesType = _selectedTypeFilter == null || e.type == _selectedTypeFilter;
      return matchesSubject && matchesType;
    }).toList();

    // Map days in current month
    final daysInMonth = DateUtils.getDaysInMonth(_currentMonth.year, _currentMonth.month);
    final firstWeekday = DateTime(_currentMonth.year, _currentMonth.month, 1).weekday; // 1 = Monday

    return Scaffold(
      appBar: AppBar(
        title: const Text('Agenda & Calendario', style: AppTypography.titleLarge),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_rounded),
            tooltip: 'Nuevo examen',
            onPressed: () => UpsertExamSheet.show(context),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        physics: appScrollPhysics(),
        children: [
          // Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: appScrollPhysics(),
            child: Row(
              children: [
                AppChip(
                  label: 'Todas las materias',
                  isSelected: _selectedSubjectFilter == null,
                  onTap: () => setState(() => _selectedSubjectFilter = null),
                ),
                ...allSubjects.map((s) => Padding(
                      padding: const EdgeInsets.only(left: AppSpacing.sm),
                      child: AppChip(
                        label: s.name,
                        isSelected: _selectedSubjectFilter == s.id,
                        activeColor: Color(s.colorValue),
                        onTap: () => setState(() => _selectedSubjectFilter = s.id),
                      ),
                    )),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),

          // Monthly Calendar Card
          AppCard(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              children: [
                // Month Selector Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.chevron_left_rounded),
                      onPressed: () => _changeMonth(-1),
                    ),
                    Text(
                      '${_monthName(_currentMonth.month)} ${_currentMonth.year}',
                      style: AppTypography.titleMedium,
                    ),
                    IconButton(
                      icon: const Icon(Icons.chevron_right_rounded),
                      onPressed: () => _changeMonth(1),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                // Days of week
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('L', style: AppTypography.caption),
                    Text('M', style: AppTypography.caption),
                    Text('M', style: AppTypography.caption),
                    Text('J', style: AppTypography.caption),
                    Text('V', style: AppTypography.caption),
                    Text('S', style: AppTypography.caption),
                    Text('D', style: AppTypography.caption),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                // Calendar Grid
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    mainAxisSpacing: 6,
                    crossAxisSpacing: 6,
                  ),
                  itemCount: (firstWeekday - 1) + daysInMonth,
                  itemBuilder: (context, index) {
                    if (index < firstWeekday - 1) {
                      return const SizedBox.shrink();
                    }
                    final dayNum = index - (firstWeekday - 1) + 1;
                    final dayDate = DateTime(_currentMonth.year, _currentMonth.month, dayNum);

                    final isSelected = DateUtils.isSameDay(dayDate, _selectedDay);
                    final isToday = DateUtils.isSameDay(dayDate, DateTime.now());

                    final dayEvents = filteredExams.where((e) => DateUtils.isSameDay(e.dateTime, dayDate)).toList();

                    return GestureDetector(
                      onTap: () {
                        setState(() => _selectedDay = dayDate);
                        if (dayEvents.isNotEmpty) {
                          _showEventsForDay(dayDate, dayEvents, allSubjects);
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected
                              ? theme.colorScheme.primary
                              : (isToday
                                  ? theme.colorScheme.primary.withValues(alpha: 0.15)
                                  : Colors.transparent),
                          borderRadius: BorderRadius.circular(8),
                          border: isToday && !isSelected
                              ? Border.all(color: theme.colorScheme.primary, width: 1.5)
                              : null,
                        ),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              dayNum.toString(),
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : (isDark ? Colors.white : Colors.black87),
                                fontWeight: isSelected || isToday ? FontWeight.bold : FontWeight.normal,
                                fontSize: 13,
                              ),
                            ),
                            if (dayEvents.isNotEmpty) ...[
                              const SizedBox(height: 2),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: dayEvents.take(3).map((e) {
                                  final sub = allSubjects.where((s) => s.id == e.subjectId).firstOrNull;
                                  return Container(
                                    width: 4,
                                    height: 4,
                                    margin: const EdgeInsets.symmetric(horizontal: 1),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? Colors.white
                                          : (sub != null ? Color(sub.colorValue) : Colors.amber),
                                      shape: BoxShape.circle,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),

          // Chronological Agenda List
          Text('Próximas evaluaciones', style: AppTypography.titleMedium),
          const SizedBox(height: AppSpacing.sm),
          if (filteredExams.isEmpty)
            const EmptyState(
              icon: Icons.event_available_rounded,
              title: 'No hay eventos en la agenda',
              description: 'Programá parciales, recuperatorios o entregas.',
            )
          else
            ...filteredExams.map((exam) {
              final sub = allSubjects.where((s) => s.id == exam.subjectId).firstOrNull;
              final subColor = sub != null ? Color(sub.colorValue) : theme.colorScheme.primary;

              return Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: AppCard(
                  onTap: () => context.push('/exams/${exam.id}'),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        decoration: ShapeDecoration(
                          color: subColor.withValues(alpha: isDark ? 0.25 : 0.12),
                          shape: AppRadius.continuousSm(),
                        ),
                        child: Column(
                          children: [
                            Text(
                              exam.dateTime.day.toString(),
                              style: AppTypography.titleLarge.copyWith(
                                color: subColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              _monthShort(exam.dateTime.month),
                              style: AppTypography.caption.copyWith(
                                color: subColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(exam.title, style: AppTypography.titleSmall),
                            Text(
                              '${sub?.name ?? ''} · ${AppFormatters.time(exam.dateTime)} hs · ${exam.type.label}',
                              style: AppTypography.caption.copyWith(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        AppFormatters.countdown(exam.dateTime),
                        style: AppTypography.caption.copyWith(
                          color: Colors.amber[800],
                          fontWeight: FontWeight.bold,
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
    );
  }

  String _monthName(int month) {
    const months = [
      'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio',
      'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'
    ];
    return months[month - 1];
  }

  String _monthShort(int month) {
    const shorts = ['ENE', 'FEB', 'MAR', 'ABR', 'MAY', 'JUN', 'JUL', 'AGO', 'SEP', 'OCT', 'NOV', 'DIC'];
    return shorts[month - 1];
  }
}
