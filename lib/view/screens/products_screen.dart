import 'package:flutter/material.dart';
import 'package:freshkart_admin/view/widgets/appbar.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppbar(title: 'Products'));
  }
}
