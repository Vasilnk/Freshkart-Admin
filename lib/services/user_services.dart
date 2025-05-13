import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freshkart_admin/model/user_model.dart';

class UserServices {
  final firestore = FirebaseFirestore.instance;

  Future<List<UserModel>> getAllUsers() async {
    final snapshot = await firestore.collection('users').get();
    return snapshot.docs.map((doc) => UserModel.fromMap(doc.data())).toList();
  }
}
