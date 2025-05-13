import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freshkart_admin/bloc/order/bloc.dart';
import 'package:freshkart_admin/bloc/order/state.dart';
import 'package:freshkart_admin/model/order_model.dart';
import 'package:freshkart_admin/utils/colors.dart';

class OrderInfoContainer extends StatelessWidget {
  final OrderModel order;
  final String orderDate;
  const OrderInfoContainer({
    super.key,
    required this.order,
    required this.orderDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          addressText("Order  Date", orderDate),
          addressText("Total Items", "${order.items.length}"),
          addressText(
            "Paid Status",
            order.paidStatus == 'Paid' ? 'Paid' : 'Cash on delivery',
          ),
          addressText("Total  Price", "₹ ${order.totalPrice}"),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Status:",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              BlocBuilder<OrderBloc, OrderState>(
                builder: (context, state) {
                  if (state is OrderLoadedState) {
                    final OrderModel currentOder = state.orders.firstWhere(
                      (ord) => ord.orderId == order.orderId,
                    );
                    return Chip(
                      label: Text(currentOder.orderStatus),

                      labelStyle: TextStyle(
                        color: AppColors.greenColor,
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  } else {
                    return Chip(
                      label: Text(order.orderStatus),

                      labelStyle: TextStyle(
                        color: AppColors.greenColor,
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget addressText(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Color.fromARGB(255, 36, 56, 170),
            ),
          ),
        ],
      ),
    );
  }
}
