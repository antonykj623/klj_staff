part of 'expense_bloc.dart';

@immutable
sealed class ExpenseState {}

final class ExpenseInitial extends ExpenseState {}


final class ExpenseReportSuccess extends ExpenseState {

  ExpenseDataEntity loginResponseEntity;

  ExpenseReportSuccess(this.loginResponseEntity);

}




final class ExpenseReportFailed extends ExpenseState {

  String message;

  ExpenseReportFailed(this.message);

}
