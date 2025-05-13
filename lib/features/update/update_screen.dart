import 'package:flutter/material.dart';
import 'package:freshkart_admin/main.dart';
import 'package:freshkart_admin/utils/colors.dart';
import 'package:freshkart_admin/utils/constants.dart';
import 'package:freshkart_admin/widgets/appbar.dart';
import 'package:go_router/go_router.dart';

class UpdateScreen extends StatelessWidget {
  UpdateScreen({super.key});

  final List<String> screens = [
    Routes.category,
    Routes.coverImages,
    Routes.notification,
    Routes.offer,
  ];

  final List<IconData> icons = [
    Icons.category,
    Icons.image,
    Icons.notification_add_sharp,
    Icons.local_offer,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'Update'),
      body: ListView.builder(
        itemCount: screens.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Material(
              color: AppColors.containerMultipleColors.keys.elementAt(index),
              borderRadius: BorderRadius.circular(15),
              child: InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap: () {
                  context.push(screens[index]);
                },
                child: Container(
                  height: 100,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.containerMultipleColors.values.elementAt(
                        index,
                      ),
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(icons[index], size: 32, color: Colors.black87),
                      const SizedBox(width: 20),
                      Text(
                        Constants.addItems[index],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
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
