import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freshkart_admin/bloc/dashboard/event.dart';
import 'package:freshkart_admin/bloc/dashboard/state.dart';
import 'package:freshkart_admin/services/dashboard_services.dart';

class DashboardBloc extends Bloc<DashBoardEvent, DashboardState> {
  DashboardServices dashboardServices = DashboardServices();
  DashboardBloc(this.dashboardServices) : super(DashboardInitial()) {
    on<DashBoardGetDataEvent>((event, emit) async {
      try {
        emit(DashboardLoading());
        final productCount = await dashboardServices.getTotalProductsCount();
        final orderCount = await dashboardServices.getTotalOrdersCount();
        final usersCount = await dashboardServices.getTotalUserCount();
        final revenueCount = await dashboardServices.getTotalRevenueCount();

        emit(
          DashboardOrderCountLoaded([
            productCount,
            orderCount,
            usersCount,
            revenueCount,
          ]),
        );
      } catch (e) {
        emit(DashboardError(e.toString()));
      }
    });

    // on<DashboardFetchTodaySummary>((event, emit) async {
    //   emit(DashboarSummarydLoading());
    //   final num revenue = await dashboardServices.getTodayRevenue();
    //   print('revenue is    fetched   $revenue');
    //   emit(FetchedTodaySummary(revenue));
    // });
  }
}
