part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}


final class LoginSuccess extends LoginState {

LoginResponseEntity loginResponseEntity;

LoginSuccess(this.loginResponseEntity);

}


final class LoginFailed extends LoginState {

String message;

LoginFailed(this.message);

}