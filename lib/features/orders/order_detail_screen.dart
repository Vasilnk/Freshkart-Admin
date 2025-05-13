import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freshkart_admin/bloc/product/product_bloc.dart';
import 'package:freshkart_admin/bloc/product/product_event.dart';
import 'package:freshkart_admin/model/order_model.dart';
import 'package:freshkart_admin/widgets/appbar.dart';
import 'package:freshkart_admin/widgets/order/customer_info_orderdetails.dart';
import 'package:freshkart_admin/widgets/order/order_details_card.dart';
import 'package:freshkart_admin/widgets/order/order_info.dart';
import 'package:freshkart_admin/widgets/order/order_status_manage_button.dart';

class OrderDetailPage extends StatefulWidget {
  final OrderModel order;
  final String orderDate;

  const OrderDetailPage({
    super.key,
    required this.order,
    required this.orderDate,
  });

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  @override
  void initState() {
    final List<dynamic> orderedProducts =
        widget.order.items.map((product) => product['productId']).toList();

    context.read<ProductBloc>().add(LoadOrderProductsEvent(orderedProducts));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'Order : ${widget.order.orderId}'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 10,
          children: [
            OrderInfoContainer(
              order: widget.order,
              orderDate: widget.orderDate,
            ),
            CustomerInfoInOrderDetails(
              order: widget.order,
              orderDate: widget.orderDate,
            ),
            OrderDetailsCard(order: widget.order),
            OrderStatusManageButton(order: widget.order),
            const SizedBox(),
          ],
        ),
      ),
    );
  }
}
