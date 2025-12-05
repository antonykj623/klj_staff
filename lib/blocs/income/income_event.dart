part of 'income_bloc.dart';

@immutable
sealed class IncomeEvent {}


class FetchAllIncome extends IncomeEvent{

  final String startdate;
  final String enddate;

  FetchAllIncome(this.startdate, this.enddate);

}