import 'package:intl/intl.dart';

formatTime(String timeString) {
  // Parse it to a DateTime
  DateTime time = DateFormat("HH:mm:ss").parse(timeString);

  // Format it to AM/PM
  String formatted = DateFormat.jm().format(time);
  return formatted;
}
