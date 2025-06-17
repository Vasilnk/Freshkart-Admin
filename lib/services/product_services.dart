import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freshkart_admin/model/product_mdel.dart';
import 'package:freshkart_admin/services/api_services/image_cloudnary_service.dart';

class FirestoreProductServices {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String collection = 'products';

  Stream<List<ProductModel>> getProducts(String categoryName) {
    final snapshot = firestore
        .collection('products')
        .where('categoryId', isEqualTo: categoryName)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return ProductModel.fromMap(doc.data(), id: doc.id);
          }).toList();
        });
    return snapshot;
  }

  addProduct(ProductModel newProduct, List<String?> imageNames) async {
    List<String?>? imageUrls = [];

    if (newProduct.images != null) {
      int count = 0;
      for (var image in newProduct.images!) {
        final imageUri = await ImageCloudnaryService.uploadImageToCloudnary(
          image!,
          imageNames[count],
        );

        imageUrls.add(imageUri);
        count++;
      }
    }
    firestore.collection('products').add({
      'name': newProduct.name,
      'categoryId': newProduct.category,
      'price': newProduct.price,
      'quantity': newProduct.quantity,
      'unitType': newProduct.unitType,
      'discription': newProduct.description,
      'images': imageUrls,
      'offer': newProduct.isOffer,
      'offerPrice': newProduct.offerPrice ?? '0',
    });
  }

  updateProduct(ProductModel updatedProduct) async {
    try {
      List<String> imageUrls = [];
      final updatedImages = updatedProduct.images;
      if (updatedImages != null) {
        for (var image in updatedImages) {
          if (image is Uint8List) {
            final img = await ImageCloudnaryService.uploadImageToCloudnary(
              image,
            );
            imageUrls.add(img);
          } else {
            imageUrls.add(image);
          }
        }
      }

      try {
        firestore.collection('products').doc(updatedProduct.docId).update({
          'name': updatedProduct.name,
          'categoryId': updatedProduct.category,
          'price': updatedProduct.price,
          'quantity': updatedProduct.quantity,
          'unitType': updatedProduct.unitType,
          'discription': updatedProduct.description,
          'images': imageUrls,
          'offer': updatedProduct.isOffer,
          'offerPrice': updatedProduct.offerPrice ?? '0',
        });
      } catch (e) {
        print('Exeption is : $e');
      }

      print('updated sucess fully');
    } catch (e) {
      print(e);
    }
  }

  deleteProduct(String docId) {
    firestore.collection(collection).doc(docId).delete();
  }

  Stream<QuerySnapshot> getOfferProducts() {
    return firestore
        .collection('products')
        .where('offer', isEqualTo: true)
        .snapshots();
  }

  Future<List<ProductModel>> getOrderProducts(
    List<dynamic> orderProductsNames,
  ) async {
    List<ProductModel> orderedProducts = [];

    for (var name in orderProductsNames) {
      final snapshot =
          await firestore
              .collection('products')
              .where('name', isEqualTo: name)
              .get();

      if (snapshot.docs.isNotEmpty) {
        orderedProducts.add(ProductModel.fromMap(snapshot.docs.first.data()));
      }
    }

    return orderedProducts;
  }
}
