import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:review_app/constants/color.dart';
import 'package:review_app/constants/elevation.dart';
import 'package:review_app/constants/shadow_color.dart';
import 'package:review_app/features/reviews/presentation/pages/activity.dart';
import 'package:review_app/features/reviews/presentation/widgets/loginRequiredBottomSheet.dart';
import 'package:review_app/features/reviews/presentation/widgets/shadow.dart';
import '../../../../main.dart';
import '../../../../utils/methods.dart';
import '../../domain/entities/string_argument.dart';
import '../../domain/entities/two_string_argument.dart';
import '../provider/bottom_nav_bar.dart';
import '../widgets/bottom_nav_icons.dart';
import 'home.dart';
import 'search.dart';
import 'leaderboard.dart';
import 'profile.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  LoginRequiredState loginRequiredObj = LoginRequiredState();
  
  final screens = [
    HomePage(),
    SearchPage(),
    ActivityPage(),
    ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    MyApp.initUserId();
    MyApp.checkAnotherDeviceLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavigationProvider>(
      builder: ((context, value, child) {
        return Scaffold(
          extendBody: true,
          backgroundColor: Colors.transparent,
          body: Container(
              decoration: BoxDecoration(gradient: AppColors.mainGradient),
              child: screens[value.currentIndex]),
          resizeToAvoidBottomInset: false,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppColors.secondaryColor10,
            elevation: AppElevations.fabButtonElev,
            child: Container(
              width: 26,
              height: 26,
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
              child: Image.asset('assets/icons/plus.png', color: AppColors.primaryColor30),
            ),
            onPressed: () {
              if(MyApp.userId == -1){
                loginRequiredObj.showLoginRequiredDialog(context);
              } else{
                Navigator.pushNamed(context, 'upload', arguments: TwoStringArg('-1', ''));
              }
            },
          ),
          bottomNavigationBar: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0)),
            child: BottomAppBar(
              elevation: AppElevations.bottomNavBarElev,
              shape: CircularNotchedRectangle(),
              notchMargin: 12,
              color: AppColors.gradientMid,
              child: Container(
                height: 65,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [

                    // Home
                    GestureDetector(
                      child: bottomNavIcons[0],
                      onTap: () {
                        value.updateIndex(0);
                      },
                    ),

                    // Liked
                    GestureDetector(
                      child: bottomNavIcons[1],
                      onTap: () {
                        if(MyApp.userId == -1){
                          loginRequiredObj.showLoginRequiredDialog(context);
                        } else{
                          value.updateIndex(1);
                        }
                      },
                    ),

                    SizedBox(width: 80.0), // Empty space for center notch

                    // Leaderboard
                    GestureDetector(
                      child: bottomNavIcons[2],
                      onTap: () {
                        value.updateIndex(2);
                      },
                    ),

                    // Profile
                    GestureDetector(
                      child: bottomNavIcons[3],
                      onTap: () {
                        if(MyApp.userId == -1){
                          loginRequiredObj.showLoginRequiredDialog(context);
                        } else{
                          value.updateIndex(3);
                        }
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
