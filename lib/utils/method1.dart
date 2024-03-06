import 'package:intl/intl.dart';

String formatDateTime(String dateTimeStr){
  DateTime dateTime = DateTime.parse(dateTimeStr);
  String formattedDateTime = DateFormat.jm().add_yMMMd().format(dateTime);

  return formattedDateTime;
}