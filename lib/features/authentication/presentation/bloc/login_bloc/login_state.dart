part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginInvalidUsernameState extends LoginState{}

class LoginInvalidPasswordState extends LoginState{}

class LoginSucessState extends LoginState{}

class LoginFailedState extends LoginState{}