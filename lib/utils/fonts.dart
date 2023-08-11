import 'package:flutter/material.dart';
import 'package:review_app/constants/color.dart';


TextStyle textTitle(){
  return const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.textColor);
}

TextStyle textSubtitle(){
  return const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textColor);
}

// In use
TextStyle subBoldText(){
  return const TextStyle(color: AppColors.textColor, fontSize: 16, fontWeight: FontWeight.bold);
}

// In use
TextStyle filterText({Color color = AppColors.primaryColor30}){
  return TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: color);
}

// In use
TextStyle hintFieldText(){
  return const TextStyle(fontSize: 18, color: AppColors.iconColor);
}

// In use
TextStyle textFieldText(){
  return const TextStyle(fontSize: 19, color: AppColors.textColor);
}

