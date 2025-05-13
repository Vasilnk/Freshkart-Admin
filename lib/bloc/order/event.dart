abstract class OrderEvent {}

class LoadOrderEvent extends OrderEvent {}

class UpdateOrderStatusEvent extends OrderEvent {
  final String status;
  final String orderId;
  UpdateOrderStatusEvent(this.status, this.orderId);
}

class FetchOrderStatusEvent extends OrderEvent {
  final dynamic orderId;
  FetchOrderStatusEvent(this.orderId);
}
