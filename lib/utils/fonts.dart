import 'package:flutter/material.dart';
import 'package:review_app/constants/color.dart';
import 'package:review_app/constants/shadow_color.dart';
import 'package:review_app/features/reviews/presentation/widgets/shadow.dart';


TextStyle textTitle(){
  return const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.textColor);
}

// In use
TextStyle subReviewPrice({Color color = AppColors.textColor, BoxShadow boxShadow = const BoxShadow(
      offset: Offset(0, 0),
      blurRadius: 0,
      color: Colors.transparent,
    ),}){
  return TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color, shadows: [boxShadow]);
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

