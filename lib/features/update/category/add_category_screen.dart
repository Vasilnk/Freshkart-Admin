import 'dart:io' as io;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freshkart_admin/bloc/category/category_bloc.dart';
import 'package:freshkart_admin/bloc/category/category_event.dart';
import 'package:freshkart_admin/model/category_model.dart';
import 'package:freshkart_admin/utils/styles.dart';
import 'package:freshkart_admin/widgets/appbar.dart';
import 'package:image_picker/image_picker.dart';

class AddCategoryPage extends StatefulWidget {
  const AddCategoryPage({super.key});

  @override
  State<AddCategoryPage> createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  final TextEditingController categoryName = TextEditingController();
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
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    bool isWeb = width > 600;
    return Scaffold(
      appBar: CustomAppbar(title: 'Add category'),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: isWeb ? width * 0.2 : 30),
          child: Column(
            spacing: 10,
            children: [
              Container(
                height: isWeb ? width * 0.4 : 250,
                width: isWeb ? width * 0.4 : 250,
                padding: EdgeInsets.all(22),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: InkWell(
                  onTap: pickImageFromGallary,

                  child: CircleAvatar(
                    backgroundImage:
                        imageBytes != null ? MemoryImage(imageBytes!) : null,
                    backgroundColor: Colors.grey[200],
                    radius: MediaQuery.of(context).size.width * 0.35,
                    child:
                        imageBytes == null
                            ? Icon(
                              Icons.image_outlined,
                              size: 70,
                              color: Colors.black,
                            )
                            : SizedBox.shrink(),
                  ),
                ),
              ),

              SizedBox(height: 8),
              TextField(
                controller: categoryName,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(
                height: isWeb ? 0 : MediaQuery.of(context).size.height * 0.21,
              ),

              ElevatedButton(
                onPressed: () async {
                  if (categoryName.text.isNotEmpty &&
                      imageBytes != null &&
                      imageName != null) {
                    CategoryModel newCategory = CategoryModel(
                      name: categoryName.text.trim(),
                      imageBytes: imageBytes,
                    );
                    context.read<CategoryBloc>().add(
                      AddCategoryEvent(newCategory, imageName!),
                    );
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('All fields is required'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                  print(' picked i s  $imageName $imageBytes');
                },
                style: AppStyles.greenElevatedButton,
                child: Text(
                  'Add Category',
                  style: AppStyles.elevatedButtonTextStyle,
                ),
              ),
              SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
