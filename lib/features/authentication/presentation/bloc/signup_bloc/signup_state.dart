part of 'signup_bloc.dart';

@immutable
abstract class SignupState {}

class SignupInitialState extends SignupState {}

class SignupLoadingState extends SignupState {}

class SignUpInvalidUsernameState extends SignupState{}

class SignupFailedState extends SignupState{}

class SignupOtpSentState extends SignupState{
  final String phoneNo;

  SignupOtpSentState({required this.phoneNo});
}

class SignupOtpSentFailedState extends SignupState{}

class OtpCodeVerifiedState extends SignupState{}

class OtpCodeVerifiedFailedState extends SignupState{}

class AddUserDataFailedState extends SignupState{}