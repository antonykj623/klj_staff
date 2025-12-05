part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardState {}

final class DashboardInitial extends DashboardState {}


final class DashboardSuccess extends DashboardState {

  DashboardEntity dashboardEntity;

  DashboardSuccess(this.dashboardEntity);

}

final class DashboardLoading extends DashboardState {

  String message;

  DashboardLoading(this.message);

}


final class DashboardFailed extends DashboardState {

  String message;

  DashboardFailed(this.message);

}