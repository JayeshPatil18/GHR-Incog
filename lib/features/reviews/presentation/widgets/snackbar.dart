import 'package:flutter/material.dart';

import '../../../../constants/color.dart';

void mySnackBarShow(BuildContext context, String text){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: AppColors.gradientStart,
      content: Text(text,
        selectionColor: AppColors.textColor))
  );
}