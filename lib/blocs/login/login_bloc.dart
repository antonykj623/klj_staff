import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:kljcafe_employee/domain/login_response_entity.dart';
import 'package:kljcafe_employee/prefdata/sharedpref.dart';
import 'package:kljcafe_employee/web/loginrepository.dart';
import 'package:meta/meta.dart';

import '../../web/api_credentials.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {

      try {
        final response =
            await LoginRepository.loginUser(event.mobile, event.password);


        if (response["status"] == 1) {
          LoginResponseEntity loginResponseEntity=LoginResponseEntity.fromJson(response);

          await SharedPref().init();

          SharedPref().setString(APICredentials.apptoken, loginResponseEntity.data!.token.toString());

          emit(LoginSuccess(loginResponseEntity));
        } else {
          emit(LoginFailed(response["message"] ?? "Login failed"));
        }
      } catch (e) {
        emit(LoginFailed(e.toString()));
      }


    },



    );
  }
}
