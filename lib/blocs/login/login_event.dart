part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}


class LoginButtonPressed extends LoginEvent{

  final String mobile;
  final String password;

  LoginButtonPressed(this.mobile, this.password);

}
