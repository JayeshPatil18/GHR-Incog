import 'package:flutter/material.dart';

class AppColors {
  // Gradient
  static const mainGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: <Color>[
      AppColors.gradientStart,
      AppColors.gradientEnd
    ],
  );
  static const gradientEnd = Color(0xFF010101);
  static const gradientStart = Color(0xFF0A3B5D);

  static const backgroundColor60 = Color(0xFF060606);
  static const primaryColor30 = Color(0xFFFFFFFF);
  static const secondaryColor10 = Color(0xFF1D9BF0);
  static const transparentComponentColor = Color.fromRGBO(255, 255, 255, 0.2);
  static const textColor = Color(0xFFFFFFFF);
  static const lightTextColor = Color.fromRGBO(255, 255, 255, 0.4);
  static const iconColor = Color(0xFFBABABA);
  static const iconLightColor = Color(0xFFe4e4e4);
  static const iconLighterColor = Color.fromARGB(255, 243, 243, 243);
  static const starColor = Color(0xffd4af37);
  static const heartColor = Color(0xfff70059);
  static const errorColor = Color(0xFFff3333);
  static const safeColor = Color(0xFF00ff00);
}

MaterialColor mainAppColor = const MaterialColor(0xFF1D9BF0, <int, Color>{
         50: Color(0xFF1D9BF0),
         100: Color(0xFF1D9BF0),
         200: Color(0xFF1D9BF0),
         300: Color(0xFF1D9BF0),
         400: Color(0xFF1D9BF0),
         500: Color(0xFF1D9BF0),
         600: Color(0xFF1D9BF0),
         700: Color(0xFF1D9BF0),
         800: Color(0xFF1D9BF0),
         900: Color(0xFF1D9BF0),
   });