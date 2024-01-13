import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:review_app/constants/color.dart';

class Line extends StatelessWidget {
  final double height;

  Line({this.height = 0.1});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.lightTextColor,
      height: height,
    );
  }
}