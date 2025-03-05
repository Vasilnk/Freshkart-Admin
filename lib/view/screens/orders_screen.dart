import 'package:flutter/material.dart';
import 'package:freshkart_admin/view/widgets/appbar.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppbar(title: 'Orders'));
  }
}
