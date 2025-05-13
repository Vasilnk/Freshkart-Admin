import 'package:equatable/equatable.dart';
import 'package:freshkart_admin/model/order_model.dart';

class OrderState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class InitialOrderState extends OrderState {}

class OrderLoadingState extends OrderState {}

class OrderLoadedState extends OrderState {
  final List<OrderModel> orders;
  OrderLoadedState(this.orders);
}

class FetchedOrderStatusState extends OrderState {
  final String status;
  FetchedOrderStatusState(this.status);
}

class OrderErrorState extends OrderState {
  final String message;
  OrderErrorState(this.message);
}
