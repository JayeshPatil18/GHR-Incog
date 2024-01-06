import 'package:bloc/bloc.dart';
import 'package:email_auth/email_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:review_app/features/authentication/presentation/pages/signup.dart';
import 'package:review_app/utils/methods.dart';

import '../../../data/repositories/users_repo.dart';

part 'signup_event.dart';

part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitialState()) {
    on<SignupEvent>((event, emit) async {
      if (event is SignupClickEvent) {
        emit(SignupLoadingState());

          bool isOtpSent = await sendEmailVerificationLink(event.email);
          if (isOtpSent) {
            emit(SignupOtpSentState(email: event.email));
          } else {
            emit(SignupOtpSentFailedState());
          }
      }
    });
  }

  Future<bool> sendEmailVerificationLink(String email) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        print('user is null');
        return false;
      }
      await user.sendEmailVerification();

      return true;
    } catch (e) {
      print(e.toString());

      return false;
    }
  }

  Future<int> validUsernameCheck(String username) async {
    UsersRepo usersRepo = UsersRepo();
    try {
      List<Map<String, dynamic>> data = await usersRepo.getUserCredentials();

      bool hasUsernameAlready = false;

      for (var userMap in data) {
        if (userMap['username'].toString().toLowerCase() == username.toLowerCase()) {
          hasUsernameAlready = true;
          break;
        }
      }
      if (!hasUsernameAlready) {
        return 1;
      } else if (hasUsernameAlready) {
        return -1;
      }
    } on Exception catch (e) {
      return 0;
    }
    return 0;
  }
}
