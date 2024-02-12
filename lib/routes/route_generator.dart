import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:review_app/features/reviews/domain/entities/image_argument.dart';
import 'package:review_app/features/reviews/domain/entities/verify_arguments.dart';
import 'package:review_app/features/reviews/presentation/pages/edit_profile.dart';
import 'package:review_app/features/reviews/presentation/pages/landing.dart';
import 'package:review_app/features/reviews/presentation/pages/notification.dart';
import 'package:review_app/features/reviews/presentation/pages/upload_review.dart';
import 'package:review_app/features/authentication/presentation/pages/verify_phone.dart';
import 'package:review_app/features/reviews/presentation/pages/view_image.dart';
import 'package:review_app/features/reviews/presentation/pages/view_profile.dart';
import 'package:review_app/features/reviews/presentation/pages/view_replies.dart';
import 'package:review_app/features/reviews/presentation/pages/view_review.dart';
import 'package:review_app/main.dart';

import '../features/authentication/presentation/pages/signup.dart';
import '../features/reviews/domain/entities/id_argument.dart';
import '../features/reviews/domain/entities/string_argument.dart';
import '../features/reviews/domain/entities/two_string_argument.dart';
import '../features/reviews/presentation/pages/view_post.dart';

class RouteGenerator {
  Route<dynamic> generateRoute(RouteSettings settings) {
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

        TwoStringArg strArguments = settings.arguments as TwoStringArg;

        String parentId = strArguments.str1;
        String text = strArguments.str2;
        return MaterialPageRoute(
            builder: (_) => UploadReview(parentId: parentId, text: text)
        );

      case 'view_image':

        ImageViewArguments arguments = settings.arguments as ImageViewArguments;

        String imageUrl = arguments.imageUrl;
        bool isNetworkUrl = arguments.isNetworkUrl;

        return MaterialPageRoute(
            builder: (_) => ViewImage(imageUrl: imageUrl, isNetworkImage: isNetworkUrl)
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

      case 'view_post':
        StringArguments strArguments = settings.arguments as StringArguments;

        String postId = strArguments.str;
        return MaterialPageRoute(
            builder: (_) => ViewPost(postId: postId)
        );

      case 'view_replies':
        TwoStringArg strArguments = settings.arguments as TwoStringArg;

        String parentPostId = strArguments.str1;
        String postId = strArguments.str2;
        return MaterialPageRoute(
            builder: (_) => ViewReplies(parentPostId: parentPostId, postId: postId)
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

      case 'verifyphone':
        VerifyArguments verifyArguments = settings.arguments as VerifyArguments;

        String email = verifyArguments.email;

        return MaterialPageRoute(
            builder: (_) => VerifyPhoneNo(email: email)
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