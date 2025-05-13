import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freshkart_admin/model/category_model.dart';
import 'package:freshkart_admin/services/api_services/image_cloudnary_service.dart';

class FirestoreCategoryService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addCategory(CategoryModel category, String imageName) async {
    final imageUri = await ImageCloudnaryService.uploadImageToCloudnary(
      category.imageBytes!,
      imageName,
    );
    await firestore.collection('categories').add({
      'name': category.name,
      'imageUrl': imageUri,
    });
  }

  Stream<QuerySnapshot> getCategories() {
    final snapShots = firestore.collection('categories').snapshots();
    return snapShots;
  }

  updateCategory(CategoryModel updatedCategory, String imageName) async {
    if (updatedCategory.imageBytes == null) {
      await firestore
          .collection('categories')
          .doc(updatedCategory.docid)
          .update({'name': updatedCategory.name});
    } else {
      final imageUri = await ImageCloudnaryService.uploadImageToCloudnary(
        updatedCategory.imageBytes!,
        imageName,
      );
      await firestore
          .collection('categories')
          .doc(updatedCategory.docid)
          .update({'name': updatedCategory.name, 'imageUrl': imageUri});
    }
  }

  deletCategory(String docId) {
    firestore.collection('categories').doc(docId).delete();
  }
}
