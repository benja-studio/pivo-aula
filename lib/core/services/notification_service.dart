import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';
import '../../features/exams/domain/exam.dart';

class NotificationService {
  static final NotificationService instance = NotificationService._internal();
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notifications = FlutterLocalNotificationsPlugin();
  bool _isInitialized = false;

  Future<void> init() async {
    if (_isInitialized) return;

    // Initialize Timezones
    tz.initializeTimeZones();
    try {
      final timeZoneName = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(timeZoneName));
    } catch (_) {
      // Fallback
      tz.setLocalLocation(tz.local);
    }

    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidSettings);

    await _notifications.initialize(initSettings);
    _isInitialized = true;
  }

  Future<bool> requestPermission() async {
    final androidImpl = _notifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    if (androidImpl != null) {
      final granted = await androidImpl.requestNotificationsPermission();
      return granted ?? false;
    }
    return false;
  }

  /// Schedules notifications for an exam:
  /// 1) 24 hours before
  /// 2) Morning of the exam (8:00 AM)
  Future<void> scheduleExamReminders(Exam exam, String subjectName) async {
    if (!exam.remindersEnabled || exam.isDeleted) {
      await cancelExamReminders(exam.id);
      return;
    }

    final examTime = exam.dateTime;
    final now = DateTime.now();

    // Notification Details
    const androidDetails = AndroidNotificationDetails(
      'aula_exams_channel',
      'Recordatorios de Evaluaciones',
      channelDescription: 'Avisos para parciales, entregas y finales.',
      importance: Importance.high,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
    );
    const details = NotificationDetails(android: androidDetails);

    // 1) 1 day before
    final oneDayBefore = examTime.subtract(const Duration(days: 1));
    if (oneDayBefore.isAfter(now)) {
      final id = (exam.id.hashCode ^ 1).abs() % 100000;
      await _notifications.zonedSchedule(
        id,
        'Examen mañana: ${exam.title}',
        '$subjectName · ${exam.type.label}',
        tz.TZDateTime.from(oneDayBefore, tz.local),
        details,
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    }

    // 2) Morning of the event (8:00 AM)
    final morningOf = DateTime(examTime.year, examTime.month, examTime.day, 8, 0);
    if (morningOf.isAfter(now) && morningOf.isBefore(examTime)) {
      final id = (exam.id.hashCode ^ 2).abs() % 100000;
      await _notifications.zonedSchedule(
        id,
        '¡Hoy rendís! ${exam.title}',
        '$subjectName a las ${examTime.hour.toString().padLeft(2, '0')}:${examTime.minute.toString().padLeft(2, '0')} hs',
        tz.TZDateTime.from(morningOf, tz.local),
        details,
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    }
  }

  Future<void> cancelExamReminders(String examId) async {
    final id1 = (examId.hashCode ^ 1).abs() % 100000;
    final id2 = (examId.hashCode ^ 2).abs() % 100000;
    await _notifications.cancel(id1);
    await _notifications.cancel(id2);
  }

  Future<void> rescheduleAll(List<Exam> exams, Map<String, String> subjectNames) async {
    await _notifications.cancelAll();
    for (final exam in exams) {
      if (exam.remindersEnabled && !exam.isDeleted) {
        final subjectName = subjectNames[exam.subjectId] ?? 'Materia';
        await scheduleExamReminders(exam, subjectName);
      }
    }
  }
}
