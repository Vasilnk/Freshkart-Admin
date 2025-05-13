import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final Map<String, dynamic> address;
  final Timestamp orderedTime;
  final List<Map<String, dynamic>> items;
  final String orderId;
  final String paidStatus;
  final String orderStatus;
  final Timestamp deliveryTime;
  final num totalPrice;
  OrderModel({
    required this.address,
    required this.orderedTime,
    required this.items,
    required this.paidStatus,
    required this.orderStatus,
    required this.deliveryTime,
    required this.totalPrice,
    required this.orderId,
  });
  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      address: map['address'],
      orderedTime: map['orderTime'],
      items: List<Map<String, dynamic>>.from(map['items']),
      paidStatus: map['paidStatus'],
      orderId: map['orderId'],
      orderStatus: map['orderStatus'],
      deliveryTime: map['delveryTime'],
      totalPrice: map['totalPrice'],
    );
  }
}
