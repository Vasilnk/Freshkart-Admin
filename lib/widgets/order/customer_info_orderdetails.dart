import 'package:flutter/material.dart';
import 'package:freshkart_admin/model/order_model.dart';

class CustomerInfoInOrderDetails extends StatelessWidget {
  final OrderModel order;
  final String orderDate;
  const CustomerInfoInOrderDetails({
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
          const Text(
            "Customer Info",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 12),
          buildInfoRow("Name", order.address['name']),
          buildInfoRow("Phone", "+91 ${order.address['phone']}"),
          const SizedBox(height: 8),
          Row(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Address: ",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Expanded(
                child: Text(
                  "${order.address['houseName']}, ${order.address['locality']}, "
                  "${order.address['pincode']}, ${order.address['city']}, ${order.address['state']}",
                  style: const TextStyle(
                    height: 1.4,
                    color: Color.fromARGB(255, 32, 55, 155),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildInfoRow(String label, String value) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 70,
          child: Text(
            "$label :",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 32, 55, 155),
            ),
          ),
        ),
      ],
    ),
  );
}
