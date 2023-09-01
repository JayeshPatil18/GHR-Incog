import 'package:flutter/material.dart';

import '../../../../constants/color.dart';

void mySnackBarShow(BuildContext context, String text){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: AppColors.textColor,
      content: Text(text,
        selectionColor: AppColors.primaryColor30))
  );
}