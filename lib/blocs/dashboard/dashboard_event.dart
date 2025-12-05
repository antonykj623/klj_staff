part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardEvent {}


class LoadDashboard extends DashboardEvent{

  final String start_date;
  final String end_date;

  LoadDashboard(this.start_date, this.end_date);

}