import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:review_app/constants/values.dart';
import 'package:review_app/features/reviews/presentation/widgets/snackbar.dart';
import 'package:review_app/utils/methods.dart';
import 'package:url_launcher/url_launcher.dart';

String formatDateTime(String dateTimeStr){

  // Time and Date Ago
  String timeAgo = timePassed(DateTime.parse(dateTimeStr), full: false);

  // Direct Date Code
  // DateTime dateTime = DateTime.parse(dateTimeStr);
  // String formattedDateTime = DateFormat.jm().add_yMMMd().format(dateTime);

  return timeAgo;
}

Future<void> launchDeveloperURL(BuildContext context) async {
  final Uri uri = Uri(scheme: "https", host: "linktr.ee", path: "/jayeshpatil.dev");
  if(!await launchUrl(
    uri,
    mode: LaunchMode.externalApplication,
  )) {
    mySnackBarShow(context, 'Unable to show info.');
  }
}