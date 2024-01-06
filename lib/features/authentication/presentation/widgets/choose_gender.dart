import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:review_app/constants/color.dart';
import 'package:review_app/features/authentication/presentation/pages/verify_phone.dart';
import 'package:review_app/utils/fonts.dart';

import '../../../../constants/boarder.dart';
import '../../../../constants/values.dart';

class ChooseGender extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ChooseGenderState();
  }
}

class ChooseGenderState extends State<ChooseGender> {
  void updateSelectedValue(String value) {
    setState(() {
      VerifyPhoneNo.gender = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10, right: 20, left: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                    onTap: () {
                      updateSelectedValue('Male');
                      Timer(Duration(milliseconds: AppValues.closeDelay), () {
                        Navigator.pop(context);
                      });
                    },
                    child: Text("Male")),
                Radio(
                  value: 'Male',
                  groupValue: VerifyPhoneNo.gender,
                  onChanged: (value) {
                    updateSelectedValue(value!);
                    Timer(Duration(milliseconds: AppValues.closeDelay), () {
                      Navigator.pop(context);
                    });
                  },
                ),
              ],
            ),
          ),
          Container(
            color: AppColors.iconColor,
            height: 1,
          ),
          Container(
            padding: EdgeInsets.only(left: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                    onTap: () {
                      updateSelectedValue('Female');
                      Timer(Duration(milliseconds: AppValues.closeDelay), () {
                        Navigator.pop(context);
                      });
                    },
                    child: Text("Female")),
                Radio(
                  value: 'Female',
                  groupValue: VerifyPhoneNo.gender,
                  onChanged: (value) {
                    updateSelectedValue(value!);
                    Timer(Duration(milliseconds: AppValues.closeDelay), () {
                      Navigator.pop(context);
                    });
                  },
                ),
              ],
            ),
          ),
          Container(
            color: AppColors.iconColor,
            height: 1,
          ),
          Container(
            padding: EdgeInsets.only(left: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                    onTap: () {
                      updateSelectedValue('other');
                      Timer(Duration(milliseconds: AppValues.closeDelay), () {
                        Navigator.pop(context);
                      });
                    },
                    child: Text('other')),
                Radio(
                  value: 'other',
                  groupValue: VerifyPhoneNo.gender,
                  onChanged: (value) {
                    updateSelectedValue(value!);
                    Timer(Duration(milliseconds: AppValues.closeDelay), () {
                      Navigator.pop(context);
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}