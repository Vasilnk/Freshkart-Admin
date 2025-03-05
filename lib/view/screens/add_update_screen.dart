import 'package:flutter/material.dart';
import 'package:freshkart_admin/core/constants.dart';
import 'package:freshkart_admin/view/screens/category_screen.dart';

import '../widgets/appbar.dart';

class AddUpdateScreen extends StatelessWidget {
  const AddUpdateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'Add & Update'),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(15),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CategoryScreen()),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 38),
                decoration: BoxDecoration(
                  color: Constants.colors.keys.elementAt(index),
                  border: Border.all(
                    color: Constants.colors.values.elementAt(index),
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text(
                    Constants.addItems[index],
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
