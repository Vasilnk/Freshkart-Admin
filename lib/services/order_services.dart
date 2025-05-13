import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freshkart_admin/model/order_model.dart';

class OrderServices {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  getAllOrders() async {
    final snapshot = await firestore.collection('orders').get();
    final orders =
        snapshot.docs.map((doc) => OrderModel.fromMap(doc.data())).toList();
    orders.sort((a, b) => (b.orderedTime).compareTo(a.orderedTime));
    return orders;
  }

  static findOrdersByCategory(String status, List<OrderModel> orders) {
    final ordersByCategory =
        orders.where((order) => order.orderStatus == status).toList();
    ordersByCategory.sort((a, b) => (b.orderedTime).compareTo(a.orderedTime));
    return ordersByCategory;
  }

  updateOrderStatus(String status, String orderId) {
    if (status == 'Confirm') status = 'Confirmed';
    firestore.collection('orders').doc(orderId).update({'orderStatus': status});

    return status;
  }

  Future<String> fetchOrderStatus(String orderId) async {
    final snapshot = await firestore.collection('orders').doc(orderId).get();
    final data = snapshot.data();
    return data?['orderStatus'] as String;
  }
}
