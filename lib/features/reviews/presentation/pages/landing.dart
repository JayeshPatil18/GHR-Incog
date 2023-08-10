import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:review_app/utils/bottom_nav_icons.dart';
import '../provider/bottom_nav_bar.dart';
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
          body: screens[value.currentIndex],
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            child: Icon(
            Icons.add, // Replace with the desired icon
            size: 40, // You can adjust the size of the icon
            color: Colors.white, // You can adjust the color of the icon
          ),
            onPressed: () {},
          ),
          bottomNavigationBar: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0)),
            child: BottomAppBar(
              shape: CircularNotchedRectangle(),
              notchMargin: 12,
              color: Colors.blue,
              child: Container(
                height: 60,
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
                    SizedBox(width: 48.0), // Empty space for center notch
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
