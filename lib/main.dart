import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:review_app/constants/color.dart';
import 'package:review_app/features/reviews/presentation/bloc/fetch_review/fetch_review_bloc.dart';
import 'package:review_app/features/reviews/presentation/bloc/upload_review/upload_review_bloc.dart';
import 'package:review_app/features/reviews/presentation/pages/home.dart';
import 'package:review_app/features/reviews/presentation/pages/landing.dart';
import 'package:review_app/features/reviews/presentation/pages/leaderboard.dart';
import 'package:review_app/features/reviews/presentation/provider/bottom_nav_bar.dart';
import 'package:review_app/routes/route_generator.dart';
import 'package:review_app/utils/methods.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upgrader/upgrader.dart';

import 'features/authentication/presentation/bloc/signup_bloc/signup_bloc.dart';
import 'features/reviews/data/repositories/realtime_db_repo.dart';
import 'features/reviews/presentation/pages/liked.dart';
import 'features/reviews/presentation/pages/profile.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Transparent Status Bar
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // transparent status bar
  ));
  // remove in production
  // await Upgrader.clearSavedSettings();

  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static int userId = -1;
  static String LOGIN_KEY = 'isLoggedIn';
  static String LOGIN_DETAILS_KEY = 'loginDetails';
  static String DOWNLOAD_VALUE_KEY = 'isFirstTime';
  static bool ENABLE_LEADERBOARD = false;

  static initUserId() async {
    List<String>? details = await getLoginDetails();
    if (details != null) {
        MyApp.userId = int.parse(details[0]);
    } else{
      MyApp.userId = -1;
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: ((context) => BottomNavigationProvider()))
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: ((context) => SignupBloc())),
          BlocProvider(create: ((context) => UploadReviewBloc())),
          BlocProvider(create: ((context) => FetchReviewBloc())),
        ], 
        child: MaterialApp(
          theme: ThemeData(primarySwatch: mainAppColor),
          debugShowCheckedModeBanner: false,
          title: 'Confession App',
          builder: (context, widget) => UpgradeAlert(
            upgrader: Upgrader(
              canDismissDialog: false,
                showIgnore: false,
                showLater: false,
                showReleaseNotes: true,
              dialogStyle: Platform.isIOS ? UpgradeDialogStyle.cupertino : UpgradeDialogStyle.material,
                durationUntilAlertAgain: Duration(hours: 4),
            ),
            child: widget!,
          ),
          initialRoute: '/',
          onGenerateRoute: RouteGenerator().generateRoute,
        ),)
    );
  }
}

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final RealTimeDbService _realTimeDbService = RealTimeDbService();
  _updateDownloadVal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool(MyApp.DOWNLOAD_VALUE_KEY) ?? true;

    if(isFirstTime){
      await _realTimeDbService.updateDownloads();
      prefs.setBool(MyApp.DOWNLOAD_VALUE_KEY, false);
    }
  }

  _setLeaderboardEnable() async{
    String? enable = await _realTimeDbService.getLeaderboardValue();
    if(enable != null){
      setState(() {
        if(int.parse(enable) == 1){
          MyApp.ENABLE_LEADERBOARD = true;
        } else{
          MyApp.ENABLE_LEADERBOARD = false;
        }
      });
    }
  }

    _checkLogin() async {
    var isLoggedIn = await checkLoginStatus();
      if(!isLoggedIn){
        Navigator.of(context).pushReplacementNamed('signup');
      } else{
        Navigator.of(context).pushReplacementNamed('landing');
      }
  }

  @override
  void initState() {
    _updateDownloadVal();
    _setLeaderboardEnable();
    _checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor60,
      body: Center(
        child: CircularProgressIndicator(
          value: 1,
        )
      )
    );
  }
}