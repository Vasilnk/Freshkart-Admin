import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freshkart_admin/bloc/order/bloc.dart';
import 'package:freshkart_admin/bloc/order/state.dart';
import 'package:freshkart_admin/model/order_model.dart';
import 'package:freshkart_admin/services/order_services.dart';
import 'package:freshkart_admin/widgets/order/order_card.dart';

class OrdersByCategory extends StatelessWidget {
  final String status;
  const OrdersByCategory({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        if (state is OrderLoadingState) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is OrderLoadedState) {
          final List<OrderModel> orders =
              status == 'All'
                  ? state.orders
                  : OrderServices.findOrdersByCategory(status, state.orders);
          if (orders.isEmpty) {
            return Center(child: Text("No $status orders"));
          }
          return ListView.builder(
            itemBuilder: (context, intex) {
              final order = orders[intex];

              return OrderCard(order: order);
            },
            itemCount: orders.length,
          );
        }
        return Center(child: Text("2 No orders in yet"));
      },
    );
  }
}
