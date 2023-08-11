import 'package:flutter/material.dart';
import 'package:review_app/constants/color.dart';


TextStyle textTitle(){
  return const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.textColor);
}

TextStyle textSubtitle(){
  return const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textColor);
}

TextStyle videoTextTitle(){
  return const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textColor);
}

TextStyle subText(){
  return const TextStyle(fontSize: 16, color: AppColors.textColor);
}

// In use
TextStyle hintFieldText(){
  return const TextStyle(fontSize: 18, color: AppColors.iconColor);
}

// In use
TextStyle textFieldText(){
  return const TextStyle(fontSize: 19, color: AppColors.textColor);
}

