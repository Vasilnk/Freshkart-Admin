import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freshkart_admin/bloc/order/event.dart';
import 'package:freshkart_admin/bloc/order/state.dart';
import 'package:freshkart_admin/model/order_model.dart';
import 'package:freshkart_admin/services/order_services.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderServices orderServices = OrderServices();
  OrderBloc(this.orderServices) : super(InitialOrderState()) {
    // Loading orders
    on<LoadOrderEvent>((event, emit) async {
      emit(OrderLoadingState());

      try {
        final List<OrderModel> orders = await orderServices.getAllOrders();
        emit(OrderLoadedState(orders));
      } catch (e) {
        emit(OrderErrorState(e.toString()));
      }
    });

    // Update status event

    on<UpdateOrderStatusEvent>((event, emit) async {
      try {
        await orderServices.updateOrderStatus(event.status, event.orderId);
      } catch (e) {
        emit(OrderErrorState(e.toString()));
      }
    });
    // Fetching status event

    on<FetchOrderStatusEvent>((event, emit) async {
      try {
        final String orderStatus = await orderServices.fetchOrderStatus(
          event.orderId,
        );
        emit(FetchedOrderStatusState(orderStatus));
      } catch (e) {
        emit(OrderErrorState(e.toString()));
      }
    });
  }
}
