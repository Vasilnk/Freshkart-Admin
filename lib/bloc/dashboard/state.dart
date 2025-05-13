import 'package:equatable/equatable.dart';

class DashboardState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardOrderCountLoaded extends DashboardState {
  final List<int> orderCount;
  DashboardOrderCountLoaded(this.orderCount);
  @override
  List<Object?> get props => [orderCount];
}

class DashboardUserCountLoaded extends DashboardState {}

class DashboardError extends DashboardState {
  final String error;
  DashboardError(this.error);
}

class DashboarSummarydLoading extends DashboardState {}

class FetchedTodaySummary extends DashboardState {
  final num revenue;
  FetchedTodaySummary(this.revenue);
  @override
  List<Object?> get props => [revenue];
}
