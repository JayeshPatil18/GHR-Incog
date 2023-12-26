import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:review_app/constants/color.dart';
import 'package:review_app/utils/fonts.dart';

import '../../../../constants/boarder.dart';
import '../../../../constants/elevation.dart';
import '../../../../constants/values.dart';
import '../../../../utils/methods.dart';
import '../pages/home.dart';
import 'circle_button.dart';
import 'shadow.dart';

class LoginRequired extends StatefulWidget {
  const LoginRequired({super.key});

  @override
  State<StatefulWidget> createState() {
    return LoginRequiredState();
  }
}

class LoginRequiredState extends State<LoginRequired> {
  void updateSelectedValue(String value) {
    setState(() {
      HomePage.selectedSort = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30, bottom: 40, right: 50, left: 50),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'Login Required !',
            style: MainFonts.pageTitleText(),
          ),
          SizedBox(height: 30),
          Container(
            height: 50,
            width: double.infinity,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                  AppColors.secondaryColor10,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(
                          AppBoarderRadius
                              .buttonRadius)),
                  elevation: AppElevations.buttonElev,
                ),
                onPressed: () {
                  Timer(Duration(milliseconds: AppValues.closeDelay), () {
                    Navigator.of(context).pop();
                    _navigateToLoginPage(context);
                  });
                },
                child: Text('Login',
                    style: AuthFonts.authButtonText())),
          ),
          SizedBox(height: 30),
          GestureDetector(
            onTap: () {
              Timer(Duration(milliseconds: AppValues.closeDelay), () {
                Navigator.pop(context);
              });
            },
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color(0xffffffff),
                    offset: Offset(-6, -6),
                    blurRadius: 10,
                    spreadRadius: 0.0,
                  ),
                  BoxShadow(
                    color: Color(0x224e4e4e),
                    offset: Offset(6, 6),
                    blurRadius: 10,
                    spreadRadius: 0.0,
                  ),
                ],
                color: AppColors.primaryColor30,
                borderRadius: BorderRadius.circular(AppBoarderRadius.filterRadius
                ),
              ),
              padding: EdgeInsets.only(top: 10, bottom: 10, left: 11, right: 11),
              child: Icon(Icons.close_rounded, color: AppColors.textColor),
            ),
          ),
        ],
      ),
    );
  }

  void showLoginRequiredDialog(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: false,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        builder: (context) =>
            DraggableScrollableSheet(
                expand: false,
                initialChildSize: 0.60,
                maxChildSize: 0.60,
                builder: (context, scrollContoller) =>
                    SingleChildScrollView(
                      child: LoginRequired(),
                    )));
  }

  void _navigateToLoginPage(BuildContext context) {
    clearSharedPrefs();
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.of(context).pushReplacementNamed('login');
  }
}