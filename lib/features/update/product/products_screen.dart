import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freshkart_admin/bloc/product/product_bloc.dart';
import 'package:freshkart_admin/bloc/product/product_event.dart';
import 'package:freshkart_admin/bloc/product/product_state.dart';
import 'package:freshkart_admin/features/update/product/add_product_screen.dart';
import 'package:freshkart_admin/utils/colors.dart';
import 'package:freshkart_admin/utils/styles.dart';
import 'package:freshkart_admin/widgets/appbar.dart';
import 'package:freshkart_admin/widgets/products_gridview.dart';

class ProductsScreen extends StatelessWidget {
  final String categoryName;
  const ProductsScreen({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    context.read<ProductBloc>().add(LoadProductsEvents(categoryName));
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: CustomAppbar(title: categoryName),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoading) {
                    return SizedBox(
                      height: height * 0.7,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColors.greenColor,
                        ),
                      ),
                    );
                  } else if (state is ProductLoaded) {
                    final products = state.products;

                    return products.isEmpty
                        ? SizedBox(height: height * 0.7)
                        : ProductsGridview(products: products);
                  }
                  return SizedBox();
                },
              ),
            ),
            Center(
              child: SizedBox(
                width: width * 0.91,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) =>
                                AddProductScreen(categoryType: categoryName),
                      ),
                    );
                  },
                  style: AppStyles.greenElevatedButton,
                  child: Text(
                    'Add Product',
                    style: AppStyles.elevatedButtonTextStyle,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
