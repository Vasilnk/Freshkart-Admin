import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freshkart_admin/model/order_model.dart';
import 'package:freshkart_admin/model/summary_model.dart';

class DashboardServices {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  getTotalOrdersCount() async {
    final snapshot = await firestore.collection('orders').get();
    return snapshot.docs.length;
  }

  getTotalRevenueCount() async {
    num total = 0;
    final orders = await getOrders();

    for (var order in orders) {
      total += order.totalPrice;
    }

    return total.toInt();
  }

  Future<List<OrderModel>> getOrders() async {
    final snapshot = await firestore.collection('orders').get();
    final orders =
        snapshot.docs.map((doc) => OrderModel.fromMap(doc.data())).toList();
    return orders;
  }

  getTotalProductsCount() async {
    final snapshot = await firestore.collection('products').get();
    return snapshot.docs.length;
  }

  getTotalUserCount() async {
    final snapshot = await firestore.collection('users').get();
    return snapshot.docs.length;
  }

  Future<SummaryModel> getTodayRevenue() async {
    final List<OrderModel> orders = await getOrders();
    num totalRevenue = 0;
    int ordersCount = 0;
    int products = 0;

    final today = DateTime.now();

    for (var order in orders) {
      final orderDate = order.orderedTime.toDate();

      if (orderDate.year == today.year &&
          orderDate.month == today.month &&
          orderDate.day == today.day) {
        totalRevenue += order.totalPrice;
        ordersCount++;
        products += order.items.length;
      }
    }
    return SummaryModel(
      orders: ordersCount,
      products: products,
      revenue: totalRevenue.toInt(),
    );
  }

  Future<SummaryModel> getThisMonthSummary() async {
    final orders = await getOrders();
    final now = DateTime.now();

    int ordersCount = 0;
    int itemCount = 0;
    int revenueCount = 0;

    for (var order in orders) {
      final orderDate = order.orderedTime.toDate();
      if (orderDate.month == now.month && orderDate.year == now.year) {
        ordersCount++;
        itemCount += order.items.length;
        revenueCount += order.totalPrice.toInt();
      }
    }

    return SummaryModel(
      orders: ordersCount,
      products: itemCount,
      revenue: revenueCount,
    );
  }

  getThisWeekSummary() async {
    final orders = await getOrders();
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday));

    int ordersCount = 0;
    int itemCount = 0;
    int revenueCount = 0;
    for (var order in orders) {
      final orderDate = order.orderedTime.toDate();
      if (orderDate.isAfter(startOfWeek)) {
        ordersCount++;
        itemCount += order.items.length;
        revenueCount += order.totalPrice.toInt();
      }
    }
    return SummaryModel(
      orders: ordersCount,
      products: itemCount,
      revenue: revenueCount,
    );
  }

  getThisYearSummary() async {
    final orders = await getOrders();
    final now = DateTime.now();
    int ordersCount = 0;
    int itemCount = 0;
    int revenueCount = 0;
    for (var order in orders) {
      final orderDate = order.orderedTime.toDate();
      if (now.year == orderDate.year) {
        ordersCount++;
        itemCount += order.items.length;
        revenueCount += order.totalPrice.toInt();
      }
    }
    return SummaryModel(
      orders: ordersCount,
      products: itemCount,
      revenue: revenueCount,
    );
  }
}
