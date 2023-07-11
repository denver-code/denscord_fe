import 'package:intl/intl.dart';

String formatTime(String timeString) {
  DateTime time = DateTime.parse(timeString);
  DateTime now = DateTime.now();

  if (time.isAfter(now.subtract(const Duration(days: 7)))) {
    // Time is within the last 24 hours
    return DateFormat("EEE HH:mm").format(time);
  } else {
    // Time is more than 24 hours ago
    return DateFormat("dd/MM/yyyy HH:mm").format(time);
  }
}
