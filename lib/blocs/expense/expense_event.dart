part of 'expense_bloc.dart';

@immutable
sealed class ExpenseEvent {}


class FetchAllExpense extends ExpenseEvent{

  final String startdate;
  final String enddate;

  FetchAllExpense(this.startdate, this.enddate);

}