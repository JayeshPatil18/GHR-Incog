import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:review_app/features/authentication/presentation/pages/forgot_password.dart';
import 'package:review_app/features/authentication/presentation/pages/change_phone.dart';
import 'package:review_app/features/reviews/domain/entities/verify_arguments.dart';
import 'package:review_app/features/reviews/presentation/pages/edit_profile.dart';
import 'package:review_app/features/reviews/presentation/pages/landing.dart';
import 'package:review_app/features/reviews/presentation/pages/notification.dart';
import 'package:review_app/features/authentication/presentation/pages/update_password.dart';
import 'package:review_app/features/reviews/presentation/pages/upload_review.dart';
import 'package:review_app/features/authentication/presentation/pages/verify_phone.dart';
import 'package:review_app/features/reviews/presentation/pages/view_profile.dart';
import 'package:review_app/features/reviews/presentation/pages/view_review.dart';
import 'package:review_app/main.dart';

import '../features/authentication/presentation/pages/signup.dart';
import '../features/authentication/presentation/pages/verify_new_phone.dart';
import '../features/reviews/domain/entities/id_argument.dart';
import '../features/reviews/domain/entities/verify_phoneno_argument.dart';

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

      case 'view_review':
        IdArguments idArguments = settings.arguments as IdArguments;

        int reviewId = idArguments.id;
        return MaterialPageRoute(
            builder: (_) => ViewReview(reviewId: reviewId)
        );

      case 'view_profile':
        IdArguments idArguments = settings.arguments as IdArguments;

        int userId = idArguments.id;
        return MaterialPageRoute(
            builder: (_) => ViewProfile(userId: userId)
        );

      case 'signup':
        return MaterialPageRoute(
          builder: (_) => const SignUpPage()
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

        VerifyArguments verifyArguments = settings.arguments as VerifyArguments;

        String email = verifyArguments.email;

        return MaterialPageRoute(
          builder: (_) => VerifyPhoneNo(email: email)
        );

      case 'verifynewphone':

        VerifyPhoneNoArg verifyPhoneNoArg = settings.arguments as VerifyPhoneNoArg;

        String phoneNo = verifyPhoneNoArg.phoneNo;
        String verifyForWhat = verifyPhoneNoArg.verifyForWhat;

        return MaterialPageRoute(
            builder: (_) => VerifyNewPhoneNo(phoneNo: phoneNo, verifyForWhat: verifyForWhat)
        );

      case 'forgotpassword':
        return MaterialPageRoute(
            builder: (_) => const ForgotPassword()
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