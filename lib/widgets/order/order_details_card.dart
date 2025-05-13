import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freshkart_admin/bloc/product/product_bloc.dart';
import 'package:freshkart_admin/bloc/product/product_state.dart';
import 'package:freshkart_admin/model/order_model.dart';
import 'package:freshkart_admin/utils/colors.dart';
import 'package:freshkart_admin/utils/styles.dart';

class OrderDetailsCard extends StatelessWidget {
  final OrderModel order;
  const OrderDetailsCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[100],
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Order Details',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductLoading) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: CircularProgressIndicator(
                        color: AppColors.greenColor,
                        strokeWidth: 2,
                      ),
                    ),
                  );
                }
                if (state is OrderProductLoaded) {
                  final orderedProducts = state.orderedProducts;
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: min(order.items.length, orderedProducts.length),
                    itemBuilder: (context, index) {
                      final item = order.items.elementAt(index);
                      final product = orderedProducts[index];
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            product.images?.first,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          product.name,
                          style: AppStyles.mediumTextStyle,
                        ),
                        subtitle: Text(
                          '${product.quantity} ${product.unitType} • Qty: ${item['quantity']}',
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 13,
                          ),
                        ),
                        trailing: Text(
                          '₹${item['price']}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      );
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            const Divider(),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Price Details',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            priceRow('Subtotal', '₹${order.totalPrice - 35}'),
            priceRow('Delivery Charge', '₹35'),
            priceRow('Discount', 'Not added'),
            const Divider(),
            priceRow('Total', '₹${order.totalPrice}', isBold: true),
          ],
        ),
      ),
    );
  }

  Widget priceRow(String label, String amount, {bool isBold = false}) {
    final style =
        isBold
            ? const TextStyle(fontWeight: FontWeight.bold)
            : const TextStyle(color: Colors.black87);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(label, style: style), Text(amount, style: style)],
      ),
    );
  }
}
