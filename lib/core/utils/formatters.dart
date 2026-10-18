import 'package:intl/intl.dart';

class AppFormatters {
  AppFormatters._();

  static final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');
  static final DateFormat _timeFormat = DateFormat('HH:mm');
  static final DateFormat _monthDayFormat = DateFormat('EEE d MMM', 'es_AR');

  static String date(DateTime dateTime) => _dateFormat.format(dateTime);

  static String time(DateTime dateTime) => _timeFormat.format(dateTime);

  static String monthDay(DateTime dateTime) {
    try {
      return _monthDayFormat.format(dateTime);
    } catch (_) {
      return '${dateTime.day}/${dateTime.month}';
    }
  }

  static String countdown(DateTime targetDate) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final target = DateTime(targetDate.year, targetDate.month, targetDate.day);
    final diffDays = target.difference(today).inDays;

    if (diffDays == 0) return 'Hoy';
    if (diffDays == 1) return 'Mañana';
    if (diffDays == 2) return 'En 2 días';
    if (diffDays > 2) return 'Faltan $diffDays días';
    if (diffDays == -1) return 'Ayer';
    return 'Pasó hace ${diffDays.abs()} días';
  }

  static String grade(double? value, {int decimals = 1}) {
    if (value == null) return '-';
    if (value == value.roundToDouble()) {
      return value.toInt().toString();
    }
    return value.toStringAsFixed(decimals);
  }
}
