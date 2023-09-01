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
  final String fullName;
  final String username;
  final String phoneNo;
  final String password;

  VerifyClickEvent({
    required this.otpCode,
    required this.fullName,
    required this.username,
    required this.phoneNo,
    required this.password,
  });
}