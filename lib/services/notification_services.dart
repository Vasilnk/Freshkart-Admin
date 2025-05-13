import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freshkart_admin/utils/colors.dart';
import 'package:go_router/go_router.dart';

class NotificationServices {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<List<Map<String, dynamic>>> getAllNotifications() async {
    final snapshot = await firestore.collection('notifications').get();
    final data = snapshot.docs;
    return data.map((doc) => doc.data()).toList();
  }

  addNotification({
    required String title,
    required String message,
    required BuildContext context,
  }) async {
    if (title.isEmpty || message.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    FirebaseFirestore.instance.collection('notifications').doc(title).set({
      'title': title,
      'message': message,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Notification saved'),
        backgroundColor: AppColors.greenColor,
      ),
    );
  }

  deleteNotification(String id, BuildContext context) {
    showDialog(
      context: context,
      builder: (c) {
        return AlertDialog(
          title: Text('Confirm'),
          actions: [
            TextButton(
              onPressed: () {
                context.pop();
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                firestore.collection('notifications').doc(id).delete();
                context.pop();
              },
              child: Text('Yes', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
