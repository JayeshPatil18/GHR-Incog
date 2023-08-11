import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:review_app/constants/color.dart';
import 'package:review_app/features/reviews/presentation/pages/home.dart';
import 'package:review_app/features/reviews/presentation/pages/leaderboard.dart';
import 'package:review_app/features/reviews/presentation/provider/bottom_nav_bar.dart';

import 'features/reviews/presentation/pages/liked.dart';
import 'features/reviews/presentation/pages/profile.dart';
import 'features/reviews/presentation/routes/route_generator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) => BottomNavigationProvider()))
      ],
      child: MaterialApp(
        theme: ThemeData(
         primarySwatch: mainAppColor
      ),
        debugShowCheckedModeBanner: false,
        title: 'Review Products',
        initialRoute: '/',
        onGenerateRoute: RouteGenerator().generateRoute,
      ),
    );
  }
}