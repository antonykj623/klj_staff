part of 'income_bloc.dart';

@immutable
sealed class IncomeEvent {}


class FetchAllIncome extends IncomeEvent{

  final String startdate;
  final String enddate;

  FetchAllIncome(this.startdate, this.enddate);

}


class FetchCustomerByID extends IncomeEvent{

  final String mobile;

  FetchCustomerByID(this.mobile);

}

class FetchCustomerByQR extends IncomeEvent{

  final String qrstring;

  FetchCustomerByQR(this.qrstring);

}
