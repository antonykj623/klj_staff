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



final class CustomerByIDSuccess extends IncomeState {

  CustomerDataEntity customerDataEntity;

  CustomerByIDSuccess(this.customerDataEntity);

}

final class CustomerByIDLoading extends IncomeState {

  String message;

  CustomerByIDLoading(this.message);

}


final class CustomerByIDFailed extends IncomeState {

  String message;

  CustomerByIDFailed(this.message);

}




final class CustomerByIDBYQRSuccess extends IncomeState {

  CustomerDataEntity customerDataEntity;

  CustomerByIDBYQRSuccess(this.customerDataEntity);

}

final class CustomerByQRLoading extends IncomeState {

  String message;

  CustomerByQRLoading(this.message);

}


final class CustomerByQRFailed extends IncomeState {

  String message;

  CustomerByQRFailed(this.message);

}
