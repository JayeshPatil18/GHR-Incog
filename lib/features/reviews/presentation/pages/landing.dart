import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:review_app/constants/color.dart';
import 'package:review_app/constants/elevation.dart';
import 'package:review_app/constants/shadow_color.dart';
import 'package:review_app/features/reviews/presentation/widgets/shadow.dart';
import '../provider/bottom_nav_bar.dart';
import '../widgets/bottom_nav_icons.dart';
import 'home.dart';
import 'liked.dart';
import 'leaderboard.dart';
import 'profile.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final screens = [
    HomePage(),
    LikedPage(),
    LeaderBoardPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavigationProvider>(
      builder: ((context, value, child) {
        return Scaffold(
          extendBody: true,
          backgroundColor: AppColors.backgroundColor60,
          body: screens[value.currentIndex],
          resizeToAvoidBottomInset: false,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppColors.secondaryColor10,
            elevation: AppElevations.fabButtonElev,
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
      color: Colors.transparent,
      borderRadius: BorderRadius.all(Radius.circular(50)),
      boxShadow: [
        BoxShadow(
          color: AppColors.secondaryColor10.withOpacity(0.2),
          spreadRadius: 3,
          blurRadius: 3,
          offset: Offset(0, 3),
        ),
      ],
    ),
              child: Icon(
              Icons.add, // Replace with the desired icon
              size: 35, // You can adjust the size of the icon
              color: AppColors.primaryColor30, // You can adjust the color of the icon
          ),
            ),
            onPressed: () {},
          ),
          bottomNavigationBar: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0)),
            child: BottomAppBar(
              elevation: AppElevations.bottomNavBarElev,
              shape: CircularNotchedRectangle(),
              notchMargin: 12,
              color: AppColors.primaryColor30,
              child: Container(
                height: 65,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      child: bottomNavIcons[0],
                      onTap: () {
                        value.updateIndex(0);
                      },
                    ),
                    GestureDetector(
                      child: bottomNavIcons[1],
                      onTap: () {
                        value.updateIndex(1);
                      },
                    ),
                    SizedBox(width: 80.0), // Empty space for center notch
                    GestureDetector(
                      child: bottomNavIcons[2],
                      onTap: () {
                        value.updateIndex(2);
                      },
                    ),
                    GestureDetector(
                      child: bottomNavIcons[3],
                      onTap: () {
                        value.updateIndex(3);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
