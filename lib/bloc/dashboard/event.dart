import 'package:equatable/equatable.dart';

class DashBoardEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class DashBoardGetDataEvent extends DashBoardEvent {}

class DashboardFetchTodaySummary extends DashBoardEvent {}
