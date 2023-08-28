import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:review_app/features/authentication/presentation/pages/login.dart';
import 'package:review_app/features/authentication/presentation/pages/change_phone.dart';
import 'package:review_app/features/reviews/presentation/pages/edit_profile.dart';
import 'package:review_app/features/reviews/presentation/pages/landing.dart';
import 'package:review_app/features/reviews/presentation/pages/notification.dart';
import 'package:review_app/features/authentication/presentation/pages/update_password.dart';
import 'package:review_app/features/reviews/presentation/pages/upload_review.dart';
import 'package:review_app/features/authentication/presentation/pages/verify_phone.dart';
import 'package:review_app/features/reviews/presentation/pages/view_review.dart';
import 'package:review_app/main.dart';

import '../features/authentication/presentation/pages/signup.dart';

class RouteGenerator{
  Route<dynamic> generateRoute(RouteSettings settings){
    
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const Splash()
        );
      
      case 'landing':
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
      
      case 'notification':
        return MaterialPageRoute(
          builder: (_) => const NotificationPage()
        );

      case 'editprofile':
        return MaterialPageRoute(
          builder: (_) => const EditProfile()
        );

      case 'updatepassowrd':
        return MaterialPageRoute(
          builder: (_) => const UpdatePassword()
        );

      case 'changephoneno':
        return MaterialPageRoute(
          builder: (_) => const ChangePhoneNo()
        );
      
      case 'verifyphone':
        return MaterialPageRoute(
          builder: (_) => VerifyPhoneNo(phoneNo: settings.arguments.toString())
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