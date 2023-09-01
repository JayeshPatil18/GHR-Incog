part of 'signup_bloc.dart';

@immutable
abstract class SignupEvent {}

class SignupClickEvent extends SignupEvent{
  final String username;
  final String phoneNo;

  SignupClickEvent({
    required this.username,
    required this.phoneNo,
  });
}

class VerifyClickEvent extends SignupEvent{
  final String otpCode;

  VerifyClickEvent({
    required this.otpCode,
  });
}