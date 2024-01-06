import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:review_app/features/reviews/presentation/widgets/bottom_sheet.dart';
import 'package:review_app/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

String suffixOfNumber(int number) {
  if (number % 100 >= 11 && number % 100 <= 13) {
    return '$number' + 'th';
  }

  switch (number % 10) {
    case 1:
      return '$number' + 'st';
    case 2:
      return '$number' + 'nd';
    case 3:
      return '$number' + 'rd';
    default:
      return '$number' + 'th';
  }
}

void openBottomSheet(BuildContext context, int index) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.80,
            maxChildSize: 0.90,
            minChildSize: 0.70,
            builder: (context, scrollContoller) => SingleChildScrollView(
              controller: scrollContoller,
              child: SelectBottomSheet(index: index),
            ),
          ));
}

bool isNumeric(String s) {
  if (s == null) {
    return false;
  }
  return double.tryParse(s) != null;
}

bool doesNotContainSpaces(String input) {
  return !input.contains(' ');
}

int getMaxRId(List<Map<String, dynamic>> data) {
  return data.map((item) => item['rid'] as int).reduce((a, b) => a > b ? a : b);
}

int getMaxUId(List<Map<String, dynamic>> data) {
  if(data.isEmpty){
    return 0;
  }
  return data.map((item) => item['uid'] as int).reduce((a, b) => a > b ? a : b);
}

// Check login status on app start
Future<bool> checkLoginStatus() async {
  bool isLoggedIn = false;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getBool(MyApp.LOGIN_KEY) != null) {
    isLoggedIn = prefs.getBool(MyApp.LOGIN_KEY)!;
  }

  return isLoggedIn;
}

// Update login status
Future<void> updateLoginStatus(bool status) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool(MyApp.LOGIN_KEY, status);
}

// Update login status
Future<void> loginDetails(String uId, String email) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setStringList(MyApp.LOGIN_DETAILS_KEY, [uId, email]);
}

// get login status
Future<List<String>?> getLoginDetails() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String>? loginDetails = prefs.getStringList(MyApp.LOGIN_DETAILS_KEY);
  return loginDetails;
}

// Update login status
Future<void> clearSharedPrefs() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.clear();
}
