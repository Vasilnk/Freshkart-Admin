import 'package:flutter/material.dart';
import 'package:freshkart_admin/model/order_model.dart';
import 'package:freshkart_admin/features/orders/order_detail_screen.dart';
import 'package:freshkart_admin/utils/colors.dart';
import 'package:freshkart_admin/utils/styles.dart';
import 'package:intl/intl.dart';

class OrderCard extends StatelessWidget {
  final OrderModel order;
  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final date = order.deliveryTime.toDate();
    final String orderDate = DateFormat("dd MMMM y").format(date);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  spacing: 13,
                  children: [
                    Text(
                      'Order No: ${order.orderId} ',
                      style: AppStyles.mediumTextStyle,
                    ),
                    Text(
                      'Items : ${order.items.length}',
                      style: AppStyles.mediumTextStyle,
                    ),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (c) => OrderDetailPage(
                                  order: order,
                                  orderDate: orderDate,
                                ),
                          ),
                        );
                      },
                      child: Text(
                        'Details',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.greenColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  spacing: 30,
                  children: [
                    Text(
                      orderDate,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '₹ ${order.totalPrice}',
                      style: AppStyles.mediumTextStyle,
                    ),

                    Text(
                      order.orderStatus,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.greenColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
