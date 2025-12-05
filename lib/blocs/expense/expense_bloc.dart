import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:kljcafe_employee/domain/expense_data_entity.dart';
import 'package:meta/meta.dart';

import '../../web/api_credentials.dart';
import '../../web/webcallRepository.dart';

part 'expense_event.dart';
part 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  ExpenseBloc() : super(ExpenseInitial()) {
    on<FetchAllExpense>((event, emit) async {
      // TODO: implement event handler

      try {


        Map mp=new HashMap();
        mp["start_date"]=event.startdate;
        mp["end_date"]=event.enddate;


        final response =
            await WebCallRepository.post(mp,APICredentials.expensereport);


        if (response["status"] == 1) {
          ExpenseDataEntity loginResponseEntity=ExpenseDataEntity.fromJson(response);


          emit(ExpenseReportSuccess(loginResponseEntity));
        } else {
          emit(ExpenseReportFailed(response["message"] ?? " failed"));
        }
      } catch (e) {
        emit(ExpenseReportFailed(e.toString()));
      }
    });
  }
}
