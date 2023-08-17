import 'package:flutter/material.dart';
import 'package:review_app/constants/color.dart';
import 'package:review_app/constants/shadow_color.dart';
import 'package:review_app/features/reviews/presentation/widgets/shadow.dart';


// Ranking User Model Fonts
//************//

// In use
TextStyle uploadButtonText(){
  return TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: AppColors.textColor);
}

// In use
TextStyle lableText(){
  return TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: AppColors.textColor);
}

// TextStyle textFieldHint(){
//   return TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: AppColors.textColor);
// }
//************//

// In use
TextStyle pageTitleText(){
  return const TextStyle(fontSize: 28, fontWeight: FontWeight.w600, color: AppColors.textColor);
}

// Profile User Model Fonts
//************//

// In use
TextStyle nameText(){
  return TextStyle(fontSize: 25, fontWeight: FontWeight.w500, color: AppColors.textColor);
}

// In use
TextStyle usernameText(){
  return TextStyle(fontSize: 17, fontWeight: FontWeight.w400, color: AppColors.textColor);
}

// In use
TextStyle userSubText(){
  return TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.textColor);
}

// In use
TextStyle userValueText(){
  return TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: AppColors.textColor);
}

// In use
TextStyle userBioText(){
  return TextStyle(fontSize: 17, fontWeight: FontWeight.w400, color: AppColors.textColor);
}
//************//

// Ranking User Model Fonts
//************//

// In use
TextStyle userRankingTitle(){
  return TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: AppColors.textColor);
}

// In use
TextStyle userRankingSubTitle(){
  return TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: AppColors.textColor);
}
//************//

// Rivew Model Fonts
//************//

// In use
TextStyle dateReview({Color color = AppColors.textColor, BoxShadow boxShadow = const BoxShadow(
      offset: Offset(0, 0),
      blurRadius: 0,
      color: Colors.transparent,
    ),}){
  return TextStyle(fontSize: 11, fontWeight: FontWeight.w400, color: color, shadows: [boxShadow]);
}

// In use
TextStyle reviewSubTitle({Color color = AppColors.textColor, BoxShadow boxShadow = const BoxShadow(
      offset: Offset(0, 0),
      blurRadius: 0,
      color: Colors.transparent,
    ),}){
  return TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: color, shadows: [boxShadow]);
}

// In use
TextStyle reviewTitle({Color color = AppColors.textColor, BoxShadow boxShadow = const BoxShadow(
      offset: Offset(0, 0),
      blurRadius: 0,
      color: Colors.transparent,
    ),}){
  return TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: color, shadows: [boxShadow]);
}

// In use
TextStyle subReviewPrice({Color color = AppColors.textColor, BoxShadow boxShadow = const BoxShadow(
      offset: Offset(0, 0),
      blurRadius: 0,
      color: Colors.transparent,
    ),}){
  return TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: color, shadows: [boxShadow]);
}
//************//

// TextStyle subBoldText(){
//   return const TextStyle(color: AppColors.textColor, fontSize: 16, fontWeight: FontWeight.bold);
// }

// In use
TextStyle filterText({Color color = AppColors.primaryColor30}){
  return TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: color);
}

// In use
TextStyle hintFieldText(){
  return const TextStyle(fontSize: 18, color: AppColors.iconColor);
}

// In use
TextStyle textFieldText(){
  return const TextStyle(fontSize: 19, color: AppColors.textColor);
}

