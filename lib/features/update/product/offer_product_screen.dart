import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freshkart_admin/bloc/product/product_bloc.dart';
import 'package:freshkart_admin/bloc/product/product_event.dart';
import 'package:freshkart_admin/bloc/product/product_state.dart';
import 'package:freshkart_admin/utils/colors.dart';
import 'package:freshkart_admin/widgets/appbar.dart';
import 'package:freshkart_admin/widgets/product_card.dart';

class OfferScreen extends StatelessWidget {
  const OfferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ProductBloc>().add(LoadOfferProductsEvent());
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppbar(title: 'Offer Products'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<ProductBloc, ProductState>(
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
                  } else if (state is OfferProductLoaded) {
                    final products = state.products;

                    return products.isEmpty
                        ? SizedBox(height: height * 0.7)
                        : GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 200,
                                childAspectRatio: 0.7,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                              ),
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            final product = products[index];
                            return ProductCard(
                              product: product,
                              offerPage: true,
                            );
                          },
                        );
                  }
                  return SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
