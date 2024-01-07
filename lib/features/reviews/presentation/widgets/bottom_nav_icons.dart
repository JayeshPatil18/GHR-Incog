import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:review_app/constants/icon_size.dart';
import 'package:review_app/features/reviews/presentation/provider/bottom_nav_bar.dart';

import '../../../../constants/color.dart';

List<Widget> bottomNavIcons = [  
  Consumer<BottomNavigationProvider>(
    builder: ((context, value, child) {
      return Container(
        color: Colors.transparent,
      padding: EdgeInsets.all(20),
      alignment: Alignment.center,
      child: Icon(Icons.home, color: value.currentIndex == 0 ? AppColors.secondaryColor10 : AppColors.lightTextColor, size: AppIconSize.bottomNavBarIcons));
    }),
  ),

  Consumer<BottomNavigationProvider>(
    builder: ((context, value, child) {
      return Container(
        color: Colors.transparent,
      padding: EdgeInsets.all(20),
      alignment: Alignment.center,
      child: Icon(Icons.favorite, color: value.currentIndex == 1 ? AppColors.secondaryColor10 : AppColors.lightTextColor, size: AppIconSize.bottomNavBarIcons));
    }),
  ),

Consumer<BottomNavigationProvider>(
    builder: ((context, value, child) {
      return Container(
        color: Colors.transparent,
      padding: EdgeInsets.all(20),
      alignment: Alignment.center,
      child: Icon(Icons.leaderboard, color: value.currentIndex == 2 ? AppColors.secondaryColor10 : AppColors.lightTextColor, size: AppIconSize.bottomNavBarIcons));
    }),
  ),

Consumer<BottomNavigationProvider>(
    builder: ((context, value, child) {
      return Container(
        color: Colors.transparent,
      padding: EdgeInsets.all(20),
      alignment: Alignment.center,
      child: Icon(Icons.person, color: value.currentIndex == 3 ? AppColors.secondaryColor10 : AppColors.lightTextColor, size: AppIconSize.bottomNavBarIcons));
    }),
  ),
];