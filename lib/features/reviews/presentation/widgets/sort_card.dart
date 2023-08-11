import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:review_app/constants/color.dart';
import 'package:review_app/utils/fonts.dart';

import '../../../../constants/boarder.dart';
import 'shadow.dart';

class SortCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SortCardState();
  }
}

class SortCardState extends State<SortCard> {
  int _selectedValue = 1;
  int _closeDelay = 400;

  void _updateSelectedValue(int value) {
    setState(() {
      _selectedValue = value;
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
              Text("Newest Uploads"),
              Radio(
                value: 1,
                groupValue: _selectedValue,
                onChanged: (value) {
                  setState(() {
                    _updateSelectedValue(value!);
                    Timer(Duration(milliseconds: _closeDelay), () {
                      Navigator.pop(context);
                    });
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
                Text("Oldest Uploads"),
                Radio(
                  value: 2,
                  groupValue: _selectedValue,
                  onChanged: (value) {
                    setState(() {
                      _updateSelectedValue(value!);
                      Timer(Duration(milliseconds: _closeDelay), () {
                        Navigator.pop(context);
                      });
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
                Text("Highest Rating"),
                Radio(
                  value: 3,
                  groupValue: _selectedValue,
                  onChanged: (value) {
                    setState(() {
                      _updateSelectedValue(value!);
                      Timer(Duration(milliseconds: _closeDelay), () {
                        Navigator.pop(context);
                      });
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
                Text("Lowest Rating"),
                Radio(
                  value: 4,
                  groupValue: _selectedValue,
                  onChanged: (value) {
                    setState(() {
                      _updateSelectedValue(value!);
                      Timer(Duration(milliseconds: _closeDelay), () {
                        Navigator.pop(context);
                      });
                    });
                  },
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              _updateSelectedValue(1);
                Timer(Duration(milliseconds: _closeDelay), () {
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
                      child: Icon(Icons.restart_alt_outlined, color: AppColors.textColor),
                    ),
          ),
        ],
      ),
    );
  }
}
