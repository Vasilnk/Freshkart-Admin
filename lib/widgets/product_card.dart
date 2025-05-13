import 'package:flutter/material.dart';
import 'package:freshkart_admin/features/update/product/update_product.dart';
import 'package:freshkart_admin/model/product_mdel.dart';
import 'package:freshkart_admin/utils/colors.dart';
import 'package:freshkart_admin/widgets/delete_icon.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  final bool offerPage;

  const ProductCard({super.key, required this.product, this.offerPage = false});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              print('category is    ${product.category}');

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UpdateProductScreen(product: product),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: SizedBox(
                      width: width * 0.6,
                      height: height * 0.13,
                      child: Image.network(
                        fit: BoxFit.contain,
                        product.images?.first ?? Icon(Icons.image),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        overflow: TextOverflow.ellipsis,
                        product.name,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('${product.quantity}  ${product.unitType}'),
                      SizedBox(height: height * 0.01),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            spacing: 10,
                            children: [
                              product.isOffer
                                  ? Text(
                                    product.offerPrice.toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                      color: const Color.fromARGB(
                                        255,
                                        35,
                                        90,
                                        134,
                                      ),
                                    ),
                                  )
                                  : SizedBox.shrink(),
                              Stack(
                                children: [
                                  Text(
                                    '₹ ${product.price}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                      color:
                                          product.isOffer
                                              ? Colors.grey
                                              : Colors.black,
                                    ),
                                  ),
                                  product.isOffer
                                      ? Positioned(
                                        top: 3,
                                        left: 2,
                                        right: 0,
                                        child: Divider(
                                          thickness: 1,
                                          color: Color.fromARGB(
                                            255,
                                            185,
                                            184,
                                            184,
                                          ),
                                        ),
                                      )
                                      : SizedBox.shrink(),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: AppColors.greenColor,
                              borderRadius: BorderRadius.circular(9),
                            ),
                            child: Icon(Icons.add, color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        offerPage
            ? SizedBox.shrink()
            : Positioned(
              top: 0,
              right: 0,
              child: DeleteIcon(
                product: product.name,
                docId: product.docId ?? '',
              ),
            ),
      ],
    );
  }
}
