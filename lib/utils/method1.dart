import 'package:intl/intl.dart';
import 'package:review_app/utils/methods.dart';

String formatDateTime(String dateTimeStr){

  // Time and Date Ago
  String timeAgo = timePassed(DateTime.parse(dateTimeStr), full: false);

  // Direct Date Code
  // DateTime dateTime = DateTime.parse(dateTimeStr);
  // String formattedDateTime = DateFormat.jm().add_yMMMd().format(dateTime);

  return timeAgo;
}