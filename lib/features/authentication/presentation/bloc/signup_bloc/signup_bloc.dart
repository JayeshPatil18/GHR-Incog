import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:review_app/features/authentication/presentation/pages/signup.dart';
import 'package:review_app/utils/methods.dart';

import '../../../data/repositories/credentials_repo.dart';
import '../../../domain/entities/user_credentials.dart';
import '../login_bloc/login_bloc.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitialState()) {
    on<SignupEvent>((event, emit) async {
      if (event is SignupClickEvent) {
        emit(SignupLoadingState());

        int validUsername = await validUsernameCheck(event.username);

        if(validUsername == 1){
          // Verification Code sending
          bool isOtpSent = await sendOtpToPhoneNumber(event.phoneNo);
          if(isOtpSent){
            emit(SignupOtpSentState(phoneNo: event.phoneNo));
          } else{
            emit(SignupOtpSentFailedState());
          }
        } else if(validUsername == -1){
          emit(SignUpInvalidUsernameState());
        } else if(validUsername == 0){
          emit(SignupFailedState());
        }
      }
    });

    on<VerifyClickEvent>((event, emit) async{
      if(event is VerifyClickEvent){
        bool isOtpVerified = await optVerify(event.otpCode);
        if(isOtpVerified){
          emit(OtpCodeVerifiedState());
        } else{
          emit(OtpCodeVerifiedFailedState());
        }
      }
    });
  }

  Future<bool> sendOtpToPhoneNumber(String phoneNo) async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        verificationCompleted: (PhoneAuthCredential credential) {
          // Handle verification completion
        },
        verificationFailed: (FirebaseAuthException e) {
          // Handle verification failure
        },
        codeSent: (String verificationId, int? resendToken) {
          SignUpPage.verify = verificationId;
        }, codeAutoRetrievalTimeout: (String verificationId) {  },
      );

      return true;

    } catch (e) {
      return false;
    }
  }

  Future<bool> optVerify(String opt) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: SignUpPage.verify, smsCode: opt);

      await auth.signInWithCredential(credential);

      updateLoginStatus(true);

      return true;

    } catch (e) {
      return false;
    }
  }
  
  
  Future<int> validUsernameCheck(String username) async {
    UserCredentialsRepo userCredentialsRepo = UserCredentialsRepo();
        try {
          UserCredentials data = await userCredentialsRepo.getUserCredentials(username);
          if(data == null || data.username.isEmpty){
            return 1;
          } if(data != null) {
            return -1;
          }
        } catch (e) {
          if(e.toString().toLowerCase().contains('no element')){
            return 1;
          } else{
            return 0;
          }
        }
        return 0;
  }
}
