import 'package:flutter/material.dart';
import 'package:freshkart_admin/features/update/category/edit_category_page.dart';
import 'package:freshkart_admin/features/update/product/products_screen.dart';
import 'package:freshkart_admin/utils/colors.dart';

class GridviewCategory extends StatelessWidget {
  final categories;
  const GridviewCategory({super.key, this.categories});

  @override
  Widget build(BuildContext context) {
    return categories.isEmpty
        ? Center(child: Text('No data'))
        : LayoutBuilder(
          builder: (context, constaints) {
            int crossAxisCount = 2;
            double childAspectRatio = 0.9;
            if (constaints.maxWidth > 950) {
              crossAxisCount = 4;
              childAspectRatio = 1.25;
            } else if (constaints.maxWidth > 900) {
              crossAxisCount = 4;
              childAspectRatio = 1.15;
            } else if (constaints.maxWidth > 650) {
              crossAxisCount = 3;
              childAspectRatio = 1.1;
            } else if (constaints.maxWidth > 600) {
              crossAxisCount = 3;
              childAspectRatio = 1;
            }
            return GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                childAspectRatio: childAspectRatio,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final imageUrl = category['imageUrl'];
                final name = category['name'];
                final docId = category.id;
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: InkWell(
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.containerMultipleColors.keys.elementAt(
                          index,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColors.containerMultipleColors.values
                              .elementAt(index),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 100,
                            width: 130,
                            child: Image.network(imageUrl),
                          ),
                          Text(
                            name,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,

                            child: InkWell(
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
                                          imageUrl: imageUrl,
                                          index: index,
                                          docId: docId,
                                        ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => ProductsScreen(categoryName: name),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          },
        );
  }
}
