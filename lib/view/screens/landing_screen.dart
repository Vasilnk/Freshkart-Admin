import 'package:flutter/material.dart';
import 'package:freshkart_admin/view/screens/account/account_screen.dart';
import 'package:freshkart_admin/view/screens/orders/orders_screen.dart';

import 'add_update_screen.dart';
import 'dashboard_screen.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  List<Widget> screens = [
    DashboardScreen(),
    AddUpdateScreen(),
    OrdersScreen(),
    AccountScreen(),
  ];

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.black,
        backgroundColor: Colors.white,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mode_edit_outline),
            label: 'Add & Update',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit_note_sharp),
            label:
                ''
                'Orders',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
        ],
      ),
    );
  }
}
