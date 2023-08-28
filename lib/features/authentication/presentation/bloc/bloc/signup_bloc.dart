import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:review_app/features/authentication/presentation/pages/signup.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitialState()) {
    on<SignupEvent>((event, emit) async {
      if (event is SignupClickEvent) {
        emit(SignupLoadingState());
        // Verification Code sending
        bool isOtpSent = await sendOtpToPhoneNumber(event.phoneNo);
        if(isOtpSent){
          emit(SignupOtpSentState(phoneNo: event.phoneNo));
        } else{
          emit(SignupOtpSentFailedState());
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

      return true;

    } catch (e) {
      return false;
    }
  }
}
