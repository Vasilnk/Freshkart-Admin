import 'package:flutter/material.dart';
import 'package:freshkart_admin/model/product_mdel.dart';
import 'package:freshkart_admin/widgets/product_card.dart';

class ProductsGridview extends StatelessWidget {
  final List<ProductModel> products;
  const ProductsGridview({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = 2;
        double childAspectRatio = 0.75;
        if (constraints.maxWidth > 1000) {
          crossAxisCount = 6;
          childAspectRatio = 0.9;
        } else if (constraints.maxWidth > 900) {
          crossAxisCount = 5;
          childAspectRatio = 0.9;
        } else if (constraints.maxWidth > 650) {
          crossAxisCount = 4;
          childAspectRatio = 0.7;
        } else if (constraints.maxWidth > 600) {
          crossAxisCount = 3;
          childAspectRatio = 0.7;
        }
        return GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: childAspectRatio,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return ProductCard(product: product);
          },
        );
      },
    );
  }
}
