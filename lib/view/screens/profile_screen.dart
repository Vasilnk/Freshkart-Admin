import 'package:flutter/material.dart';
import 'package:freshkart_admin/view/widgets/appbar.dart';
import 'package:freshkart_admin/view/widgets/profile_container.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'Profile'),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            FieldContainer(title: 'Admin Id', value: 'value'),
            SizedBox(height: 30),
            FieldContainer(title: 'Password', value: 'value'),
          ],
        ),
      ),
    );
  }
}
