import 'dart:io' as io;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freshkart_admin/bloc/category/category_bloc.dart';
import 'package:freshkart_admin/bloc/category/category_event.dart';
import 'package:freshkart_admin/bloc/product/product_bloc.dart';
import 'package:freshkart_admin/bloc/product/product_event.dart';
import 'package:freshkart_admin/bloc/product/product_state.dart';
import 'package:freshkart_admin/model/category_model.dart';
import 'package:freshkart_admin/utils/colors.dart';
import 'package:freshkart_admin/utils/styles.dart';
import 'package:freshkart_admin/widgets/appbar.dart';
import 'package:image_picker/image_picker.dart';

class EditCategoryPage extends StatefulWidget {
  final String name;
  final String imageUrl;
  final int index;
  final String docId;
  const EditCategoryPage({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.index,
    required this.docId,
  });

  @override
  State<EditCategoryPage> createState() => _EditCategoryPageState();
}

class _EditCategoryPageState extends State<EditCategoryPage> {
  final TextEditingController nameController = TextEditingController();
  Uint8List? imageBytes;
  String? imageName;
  ImagePicker picker = ImagePicker();
  pickImageFromGallary() async {
    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageName = pickedFile.name;
      if (kIsWeb) {
        imageBytes = await pickedFile.readAsBytes();
      } else {
        final file = io.File(pickedFile.path);
        imageBytes = await file.readAsBytes();
      }
      setState(() {});
    }
  }

  @override
  void initState() {
    nameController.text = widget.name;
    context.read<ProductBloc>().add(LoadProductsEvents(widget.name));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    bool isWeb = width > 600;
    return Scaffold(
      appBar: CustomAppbar(title: 'Edit category'),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: isWeb ? width * 0.1 : 30),
        child: Column(
          spacing: 10,
          children: [
            InkWell(
              onTap: pickImageFromGallary,
              child: Container(
                width: width * 0.8,
                height: isWeb ? height * 0.5 : height * 0.38,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.containerMultipleColors.keys.elementAt(
                    widget.index,
                  ),
                  border: Border.all(
                    color: AppColors.containerMultipleColors.values.elementAt(
                      widget.index,
                    ),
                    width: 2,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child:
                      imageBytes != null
                          ? Image.memory(imageBytes!, fit: BoxFit.contain)
                          : Image.network(widget.imageUrl, fit: BoxFit.contain),
                ),
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: isWeb ? 0 : height * 0.15),

            ElevatedButton(
              onPressed: () async {
                String name = nameController.text.trim();

                if (imageBytes == null) {
                  if (name != widget.name) {
                    final updatedCategory = CategoryModel(
                      name: name,
                      docid: widget.docId,
                    );
                    context.read<CategoryBloc>().add(
                      UpdateCategoryEvent(updatedCategory, ''),
                    );
                  }
                } else if (imageBytes != null && imageName != null) {
                  final updatedCategory = CategoryModel(
                    name: name,
                    docid: widget.docId,
                    imageBytes: imageBytes,
                  );
                  context.read<CategoryBloc>().add(
                    UpdateCategoryEvent(updatedCategory, imageName ?? ''),
                  );
                }

                await Future.delayed(Duration(seconds: 1));

                Navigator.pop(context);
              },
              style: AppStyles.greenElevatedButton,
              child: Text('Update', style: AppStyles.elevatedButtonTextStyle),
            ),
            BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: () {
                    if (state is ProductLoaded) {
                      if (state.products.isEmpty) {
                        context.read<CategoryBloc>().add(
                          DeleteCategoryEvent(widget.docId),
                        );
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,

                            content: Text(
                              "This category cannot be deleted because it contains products.",
                            ),
                          ),
                        );
                      }
                    }
                  },
                  style: AppStyles.redElevatedButtonStyle,
                  child: Text(
                    'Delete',
                    style: AppStyles.redelevatedButtonTextStyle,
                  ),
                );
              },
            ),
            SizedBox(),
          ],
        ),
      ),
    );
  }
}
