import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CustomAppbar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Column(
        children: [
          SizedBox(height: 35),
          Text(
            title,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
          ),
        ],
      ),
      centerTitle: true,
      automaticallyImplyLeading: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
