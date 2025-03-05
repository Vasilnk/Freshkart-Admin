import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freshkart_admin/model/category_model.dart';

class CategoryServices {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addCategory(CategoryModel category) async {
    DocumentReference ref = firestore.collection('categories').doc();
    await ref.set({'name': category.name, 'image': category.image});
  }
}
