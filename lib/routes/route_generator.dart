import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:review_app/features/authentication/presentation/pages/login.dart';
import 'package:review_app/features/reviews/presentation/pages/landing.dart';
import 'package:review_app/features/reviews/presentation/pages/upload_review.dart';
import 'package:review_app/main.dart';

import '../features/authentication/presentation/pages/signup.dart';

class RouteGenerator{
  Route<dynamic> generateRoute(RouteSettings settings){
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const LandingPage()
        );

      case 'upload':
        return MaterialPageRoute(
          builder: (_) => const UploadReview()
        );

      case 'signup':
        return MaterialPageRoute(
          builder: (_) => const SignUpPage()
        );

      case 'login':
        return MaterialPageRoute(
          builder: (_) => const LoginPage()
        );

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          body: const Center(
            child: Text("ERROR"),
          ),
        );
      }
    );
  }
}