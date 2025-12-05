import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:kljcafe_employee/domain/income_data_entity.dart';
import 'package:kljcafe_employee/web/api_credentials.dart';
import 'package:meta/meta.dart';

import '../../prefdata/sharedpref.dart';
import '../../web/webcallRepository.dart';

part 'income_event.dart';
part 'income_state.dart';

class IncomeBloc extends Bloc<IncomeEvent, IncomeState> {
  IncomeBloc() : super(IncomeInitial()) {
    on<FetchAllIncome>((event, emit) async {
      // TODO: implement event handler

      try {
        emit(IncomeReportLoading(""));

        Map mp=new HashMap();
        mp["start_date"]=event.startdate;
        mp["end_date"]=event.enddate;


        final response =
            await WebCallRepository.post(mp,APICredentials.incomereport);


        if (response["status"] == 1) {
          IncomeDataEntity loginResponseEntity=IncomeDataEntity.fromJson(response);


          emit(IncomeReportSuccess(loginResponseEntity));
        } else {
          emit(IncomeReportFailed(response["message"] ?? " failed"));
        }
      } catch (e) {
        emit(IncomeReportFailed(e.toString()));
      }

    });
  }
}
