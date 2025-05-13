import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freshkart_admin/bloc/order/bloc.dart';
import 'package:freshkart_admin/bloc/order/event.dart';
import 'package:freshkart_admin/model/order_model.dart';
import 'package:freshkart_admin/utils/colors.dart';
import 'package:freshkart_admin/utils/constants.dart';

class OrderStatusManageButton extends StatelessWidget {
  final OrderModel order;
  const OrderStatusManageButton({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          if (order.orderStatus == 'Delivered') {
            showFlushBar(context);
          } else {
            showManageStatusDialog(context, order.orderStatus, order.orderId);
          }
        },
        icon: const Icon(Icons.edit, color: Colors.white),
        label: const Text(
          "Manage Order Status",
          style: TextStyle(color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: AppColors.greenColor,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
        ),
      ),
    );
  }

  void showManageStatusDialog(
    BuildContext context,
    String currentStatus,
    String orderId,
  ) {
    String? selectedStatus;
    final validStatuses = Constants.validNextStatuses[currentStatus] ?? [];

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text(
                "Update Order Status",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 25, 54, 104),
                ),
              ),
              content: DropdownButtonFormField<String>(
                value: selectedStatus,
                decoration: const InputDecoration(labelText: "Select Status"),
                items:
                    validStatuses
                        .map(
                          (status) => DropdownMenuItem(
                            value: status,
                            child: Text(status),
                          ),
                        )
                        .toList(),
                onChanged:
                    (value) => setState(() {
                      selectedStatus = value;
                    }),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (selectedStatus != null) {
                      context.read<OrderBloc>().add(
                        UpdateOrderStatusEvent(selectedStatus!, orderId),
                      );

                      context.read<OrderBloc>().add(LoadOrderEvent());
                    }

                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.greenColor,
                  ),
                  child: const Text(
                    "Update",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  showFlushBar(BuildContext context) {
    Flushbar(
      message: 'Order is Delivered',
      duration: const Duration(seconds: 3),
      backgroundColor: const Color.fromARGB(255, 35, 61, 134),
      flushbarPosition: FlushbarPosition.TOP,
      margin: const EdgeInsets.all(10),
      borderRadius: BorderRadius.circular(8),
    ).show(context);
  }
}
