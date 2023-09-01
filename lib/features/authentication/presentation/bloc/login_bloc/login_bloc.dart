import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:review_app/features/authentication/presentation/pages/signup.dart';
import 'package:review_app/utils/methods.dart';

import '../../../data/repositories/credentials_repo.dart';
import '../../../domain/entities/user_credentials.dart';

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
          UserCredentials data = await userCredentialsRepo.getUserCredentials(event.username);
          if(data == null || data.username.isEmpty){
            emit(LoginInvalidUsernameState());
          } else if(data.password != event.password){
            emit(LoginInvalidPasswordState());
          } else if(data.password == event.password){
            updateLoginStatus(true);
            emit(LoginSucessState());
          }
        } catch (e) {
          if(e.toString().toLowerCase().contains('no element')){
            emit(LoginInvalidUsernameState());
          } else{
            emit(LoginFailedState());
          }
        }
      }
    });
  }
}
