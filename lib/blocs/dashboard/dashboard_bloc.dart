import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:kljcafe_employee/domain/dashboard_entity.dart';
import 'package:kljcafe_employee/web/api_credentials.dart';
import 'package:kljcafe_employee/web/webcallRepository.dart';
import 'package:meta/meta.dart';

import '../../prefdata/sharedpref.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial()) {
    on<LoadDashboard>((event, emit) async {
      // TODO: implement event handler

      try {
        emit(DashboardLoading(""));


        Map mp=new HashMap();
        mp["start_date"]=event.start_date;
        mp["end_date"]=event.end_date;

        final response =
            await WebCallRepository.post(mp, APICredentials.getAllTransactions);


        if (response["status"] == 1) {
          DashboardEntity loginResponseEntity=DashboardEntity.fromJson(response);

          await SharedPref().init();


          emit(DashboardSuccess(loginResponseEntity));
        } else {
          emit(DashboardFailed(response["message"] ?? "Login failed"));
        }
      } catch (e) {
        emit(DashboardFailed(e.toString()));
      }

    });
  }
}
