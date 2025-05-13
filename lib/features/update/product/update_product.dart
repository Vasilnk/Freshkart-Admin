import 'dart:io' as io;
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freshkart_admin/bloc/product/product_bloc.dart';
import 'package:freshkart_admin/bloc/product/product_event.dart';
import 'package:freshkart_admin/model/product_mdel.dart';
import 'package:freshkart_admin/utils/colors.dart';
import 'package:freshkart_admin/utils/styles.dart';
import 'package:freshkart_admin/widgets/appbar.dart';
import 'package:freshkart_admin/widgets/text__field.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProductScreen extends StatefulWidget {
  final ProductModel product;

  const UpdateProductScreen({super.key, required this.product});

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController discriptionController = TextEditingController();
  final TextEditingController offerPriceController = TextEditingController();
  final productKey = GlobalKey<FormState>();
  String? unitType;
  final List<Uint8List?> images = List.generate(4, (_) => null);
  // final List<String?> imageNames = List.generate(4, (_) => null);

  bool? isOffer;

  Future<void> _pickImage(int index) async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      // imageNames[index] = pickedFile.name;

      if (kIsWeb) {
        images[index] = await pickedFile.readAsBytes();
      } else {
        final file = io.File(pickedFile.path);

        images[index] = await file.readAsBytes();
      }

      setState(() {});
    }
  }

  @override
  void initState() {
    nameController.text = widget.product.name;
    priceController.text = widget.product.price;
    quantityController.text = widget.product.quantity;
    discriptionController.text = widget.product.description;
    unitType = widget.product.unitType;
    isOffer = widget.product.isOffer;
    offerPriceController.text = widget.product.offerPrice ?? '0';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('category is    ${widget.product.category}');

    double width = MediaQuery.of(context).size.width;
    bool isWeb = width > 600;
    return Scaffold(
      appBar: CustomAppbar(title: 'Update Product'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: isWeb ? width * 0.1 : 20),
          child: Form(
            key: productKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 10,
              children: [
                SizedBox(
                  height: isWeb ? 400 : 250,
                  width: width * 0.8,
                  child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context).copyWith(
                      dragDevices: {
                        PointerDeviceKind.touch,
                        PointerDeviceKind.mouse,
                      },
                    ),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: images.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () => _pickImage(index),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: isWeb ? 350 : width * 0.7,
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey),
                                color: Colors.grey[200],
                              ),
                              child:
                                  images[index] == null
                                      ? ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          widget.product.images?[index] ?? '',
                                          // width: 100,
                                          // height: 100,
                                          fit: BoxFit.fill,
                                        ),
                                      )
                                      : ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.memory(
                                          images[index]!,
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                CustomTextField(controller: nameController, label: 'Name'),
                Row(
                  spacing: 10,
                  children: [
                    Flexible(
                      flex: 1,
                      child: CustomTextField(
                        controller: priceController,
                        label: 'Price',
                        isNumber: true,
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Row(
                        children: [
                          Checkbox(
                            checkColor: AppColors.greenColor,
                            fillColor: WidgetStateProperty.all(Colors.white),

                            value: isOffer,
                            onChanged: (value) {
                              setState(() {
                                isOffer = value!;
                              });
                            },
                          ),
                          Text('Offer product'),
                        ],
                      ),
                    ),
                  ],
                ),
                isOffer == true
                    ? Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomTextField(
                          controller: offerPriceController,
                          label: 'Offer price',
                          smallSize: true,
                          isNumber: true,
                        ),
                      ],
                    )
                    : SizedBox.shrink(),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        controller: quantityController,
                        label: 'Quantity',
                        isNumber: true,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        dropdownColor: Colors.white,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        value: unitType,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'select one unit';
                          } else {
                            return null;
                          }
                        },
                        items:
                            ['g', 'Kg', 'ml', 'L'].map((unit) {
                              return DropdownMenuItem(
                                value: unit,
                                child: Text(unit),
                              );
                            }).toList(),
                        onChanged: (value) {
                          setState(() {
                            unitType = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                CustomTextField(
                  controller: discriptionController,
                  label: 'Discription',
                  lines: 2,
                ),
                SizedBox(height: 30),

                ElevatedButton(
                  onPressed: () {
                    // Validate the form first
                    if (!productKey.currentState!.validate()) return;

                    // Build the updated image list (use existing image if new one not provided)
                    final updatedImages = List.generate(4, (index) {
                      return images[index] ?? widget.product.images?[index];
                    });

                    print('category is    ${widget.product.category}');
                    final updatedProduct = ProductModel(
                      category: widget.product.category,
                      name: nameController.text.trim(),
                      price: priceController.text.trim(),
                      quantity: quantityController.text.trim(),
                      unitType: unitType ?? widget.product.unitType,
                      description: discriptionController.text.trim(),
                      images: updatedImages,
                      docId: widget.product.docId,
                      isOffer: isOffer ?? false,
                      offerPrice: offerPriceController.text.trim(),
                    );

                    // Dispatch the update event
                    context.read<ProductBloc>().add(
                      UpdateProductEvent(updatedProduct),
                    );

                    // Navigate back
                    Navigator.pop(context);
                  },
                  style: AppStyles.greenElevatedButton,
                  child: Text('Update', style: AppStyles.bigButtonTextStyle),
                ),

                SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
