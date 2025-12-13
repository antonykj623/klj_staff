import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:kljcafe_employee/domain/customer_data_entity.dart';
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

    on<FetchCustomerByID>((event, emit) async {
      // TODO: implement event handler

      try {
        emit(CustomerByIDLoading(""));





        final response =
        await WebCallRepository.get(APICredentials.getCustomerDetailsByMobile+"?mobile="+event.mobile);


        if (response["status"] == 1) {
          CustomerDataEntity loginResponseEntity=CustomerDataEntity.fromJson(response);


          emit(CustomerByIDSuccess(loginResponseEntity));
        } else {
          emit(CustomerByIDFailed(response["message"] ?? " failed"));
        }
      } catch (e) {
        emit(CustomerByIDFailed(e.toString()));
      }

    });

    on<FetchCustomerByQR>((event, emit) async {
      // TODO: implement event handler

      try {
        emit(CustomerByQRLoading(""));





        final response =
        await WebCallRepository.get(APICredentials.decryptQRToken+"?qrtoken="+event.qrstring);


        if (response["status"] == 1) {
          CustomerDataEntity loginResponseEntity=CustomerDataEntity.fromJson(response);


          emit(CustomerByIDBYQRSuccess(loginResponseEntity));
        } else {
          emit(CustomerByQRFailed(response["message"] ?? " failed"));
        }
      } catch (e) {
        emit(CustomerByQRFailed(e.toString()));
      }

    });

    on<AddIncomeUser>((event, emit) async {
      // TODO: implement event handler

      try {
        emit(AddIncomeLoading(""));
        // $amount=$_POST['amount'];
        // $wallet_amount=$_POST['wallet_amount'];
        // $description=$_POST['description'];
        // $entered_date=$_POST['date'];
        // $userid_toSendwalletamount=$_POST['userid_toSendwalletamount'];

        Map mp=new HashMap();
        mp["userid_toSendwalletamount"]=event.userid;
        mp["date"]=event.date;
        mp["description"]=event.description;
        mp["wallet_amount"]=event.waletamount;
        mp["amount"]=event.amount;





        final response =
        await WebCallRepository.post(mp,APICredentials.addIncome);


        if (response["status"] == 1) {


          emit(AddIncomeSuccess("Success"));
        } else {
          emit(AddIncomeFailed(response["message"] ?? " failed"));
        }
      } catch (e) {
        emit(AddIncomeFailed(e.toString()));
      }

    });
  }
}
