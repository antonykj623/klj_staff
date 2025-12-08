part of 'expense_bloc.dart';

@immutable
sealed class ExpenseState {}

final class ExpenseInitial extends ExpenseState {}


final class ExpenseReportSuccess extends ExpenseState {

  ExpenseDataEntity expenseDataEntity;

  ExpenseReportSuccess(this.expenseDataEntity);

}




final class ExpenseReportFailed extends ExpenseState {

  String message;

  ExpenseReportFailed(this.message);

}



final class QRSuccess extends ExpenseState {

  QrEntity qrEntity;

  QRSuccess(this.qrEntity);

}

final class QRLoading extends ExpenseState {

  String message;

  QRLoading(this.message);

}


final class QRFailed extends ExpenseState {

  String message;

  QRFailed(this.message);

}




final class AddExpenseSuccess extends ExpenseState {

String message;

  AddExpenseSuccess(this.message);

}

final class AddExpenseLoading extends ExpenseState {

  String message;

  AddExpenseLoading(this.message);

}


final class AddExpenseFailed extends ExpenseState {

  String message;

  AddExpenseFailed(this.message);

}