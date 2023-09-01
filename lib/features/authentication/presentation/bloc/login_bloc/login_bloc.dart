import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:review_app/features/authentication/presentation/pages/signup.dart';
import 'package:review_app/utils/methods.dart';

import '../../../data/repositories/users_repo.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitialState()) {
    on<LoginEvent>((event, emit) async {
      if (event is LoginClickEvent) {
        emit(LoginLoadingState());
        // Verify Login Cridentials
        UserCredentialsRepo userCredentialsRepo = UserCredentialsRepo();
        try {
          List<Map<String, dynamic>> data =
              await userCredentialsRepo.getUserCredentials();

          bool hasUsernameAlready = false;
          String password = '';

          for (var userMap in data) {
            if (userMap['username'] == event.username) {
              hasUsernameAlready = true;
              password = userMap['password'];
              break;
            }
          }

          if (!hasUsernameAlready) {
            emit(LoginInvalidUsernameState());
          } else if (password != event.password) {
            emit(LoginInvalidPasswordState());
          } else if (password == event.password) {
            updateLoginStatus(true);
            emit(LoginSucessState());
          }
        } catch (e) {
          emit(LoginFailedState());
        }
      }
    });
  }
}
