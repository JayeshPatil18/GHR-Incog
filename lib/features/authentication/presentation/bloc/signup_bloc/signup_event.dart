part of 'signup_bloc.dart';

@immutable
abstract class SignupEvent {}

class SignupClickEvent extends SignupEvent{
  final String email;

  SignupClickEvent({
    required this.email
  });
}

class VerifyClickEvent extends SignupEvent{
  final String otpCode;
  final String email;

  VerifyClickEvent({
    required this.otpCode,
    required this.email,
  });
}