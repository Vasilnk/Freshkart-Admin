import 'package:cloud_firestore/cloud_firestore.dart';

class AdminServices {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<Map<String, dynamic>?> fatchAdmin() async {
    final snapshot =
        await firestore.collection('admin').doc('FOKZ08SXgwEkwNMVqn55').get();

    return snapshot.data();
  }

  updateAdminField(String value, bool adminId) {
    if (adminId) {
      firestore.collection('admin').doc('FOKZ08SXgwEkwNMVqn55').update({
        'adminId': value,
      });
    } else {
      firestore.collection('admin').doc('FOKZ08SXgwEkwNMVqn55').update({
        'password': value,
      });
    }
  }
}
