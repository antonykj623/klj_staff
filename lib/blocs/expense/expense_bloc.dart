import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:kljcafe_employee/domain/expense_data_entity.dart';
import 'package:kljcafe_employee/domain/qr_entity.dart';
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

    on<FetchQR>((event, emit) async {
      // TODO: implement event handler

      try {

        emit(QRLoading(""));

        Map mp=new HashMap();


        final response =
        await WebCallRepository.post(mp,APICredentials.generateQRToken);


        if (response["status"] == 1) {
          QrEntity loginResponseEntity=QrEntity.fromJson(response);


          emit(QRSuccess(loginResponseEntity));
        } else {
          emit(QRFailed(response["message"] ?? " failed"));
        }
      } catch (e) {
        emit(QRFailed(e.toString()));
      }
    });

    on<AddExpense>((event, emit) async {
      // TODO: implement event handler

      try {

        emit(AddExpenseLoading(""));

        Map mp=new HashMap();
        mp["amount"]=event.amount;
        mp["description"]=event.description;
        mp["date"]=event.entered_date;


        final response =
        await WebCallRepository.post(mp,APICredentials.addExpense);


        if (response["status"] == 1) {



          emit(AddExpenseSuccess(response["message"]));
        } else {
          emit(AddExpenseFailed(response["message"] ?? " failed"));
        }
      } catch (e) {
        emit(AddExpenseFailed(e.toString()));
      }
    });
  }
}
