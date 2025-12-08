part of 'income_bloc.dart';

@immutable
sealed class IncomeState {}

final class IncomeInitial extends IncomeState {}

final class IncomeReportSuccess extends IncomeState {

  IncomeDataEntity incomeDataEntity;

  IncomeReportSuccess(this.incomeDataEntity);

}

final class IncomeReportLoading extends IncomeState {

  String message;

  IncomeReportLoading(this.message);

}


final class IncomeReportFailed extends IncomeState {

  String message;

  IncomeReportFailed(this.message);

}



