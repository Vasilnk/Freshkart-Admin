import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freshkart_admin/bloc/category/category_bloc.dart';
import 'package:freshkart_admin/bloc/category/category_event.dart';
import 'package:freshkart_admin/bloc/category/category_state.dart';
import 'package:freshkart_admin/main.dart';
import 'package:freshkart_admin/utils/colors.dart';
import 'package:freshkart_admin/utils/styles.dart';
import 'package:freshkart_admin/widgets/appbar.dart';
import 'package:freshkart_admin/widgets/category_gridview.dart';
import 'package:freshkart_admin/widgets/snackbar.dart';
import 'package:go_router/go_router.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<CategoryBloc>().add(LoadCategoriesEvent());
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: CustomAppbar(title: 'Categories'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, state) {
                  switch (state) {
                    case CategoryLoading():
                      return SizedBox(
                        height: height * 0.7,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppColors.greenColor,
                          ),
                        ),
                      );
                    case CategoryLoaded():
                      final categories = state.categories;
                      return GridviewCategory(categories: categories);
                    case CategoryError():
                      CustomSnackbar.showCustomSnackBar(context, state.message);
                    default:
                      return SizedBox.shrink();
                  }

                  return SizedBox.shrink();
                },
              ),
              SizedBox(
                width: width * 0.91,
                child: ElevatedButton(
                  onPressed: () {
                    context.push(Routes.addCategory);
                  },
                  style: AppStyles.greenElevatedButton,
                  child: Text(
                    'Add Category',
                    style: AppStyles.elevatedButtonTextStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
