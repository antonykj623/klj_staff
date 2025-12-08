part of 'expense_bloc.dart';

@immutable
sealed class ExpenseEvent {}


class FetchAllExpense extends ExpenseEvent{

  final String startdate;
  final String enddate;

  FetchAllExpense(this.startdate, this.enddate);

}

class FetchQR extends ExpenseEvent{



  FetchQR();

}



class AddExpense extends ExpenseEvent{

  final String amount;
  final String entered_date;
  String description;

  AddExpense(this.amount, this.entered_date,this.description);

}