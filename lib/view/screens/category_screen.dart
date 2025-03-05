import 'package:flutter/material.dart';
import 'package:freshkart_admin/core/constants.dart';
import 'package:freshkart_admin/view/screens/edit_category_page.dart';
import 'package:freshkart_admin/view/screens/products_screen.dart';

import '../widgets/appbar.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'Categories'),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
        ),
        itemCount: 3,
        itemBuilder: (context, index) {
          final image = Constants.categories.values.elementAt(index);
          final name = Constants.categories.keys.elementAt(index);
          return Padding(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Constants.colors.keys.elementAt(index),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Constants.colors.values.elementAt(index),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 130,
                      width: 130,
                      child: Image.asset(image),
                    ),
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          child: Text(
                            'edit',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => EditCategoryPage(
                                      name: name,
                                      image: image,
                                    ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductsScreen()),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
