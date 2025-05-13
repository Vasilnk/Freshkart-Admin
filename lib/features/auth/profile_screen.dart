import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freshkart_admin/bloc/admin/admin_bloc.dart';
import 'package:freshkart_admin/bloc/admin/admin_event.dart';
import 'package:freshkart_admin/bloc/admin/admin_state.dart';
import 'package:freshkart_admin/main.dart';
import 'package:freshkart_admin/widgets/appbar.dart';
import 'package:freshkart_admin/widgets/profile_container.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AdminBloc>().add(FetchEvent());
    return Scaffold(
      appBar: CustomAppbar(title: 'Profile'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: BlocBuilder<AdminBloc, AdminState>(
              builder: (context, state) {
                if (state is AdminLoaded) {
                  String passrord = '';
                  state.password.split('').forEach((l) {
                    state.password.indexOf(l) % 2 == 0
                        ? passrord += l
                        : passrord += '-';
                  });
                  return Column(
                    children: [
                      FieldContainer(title: 'Admin Id', value: state.id),
                      SizedBox(height: 30),
                      FieldContainer(title: 'Password', value: passrord),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      FieldContainer(title: 'Admin Id', value: ''),
                      SizedBox(height: 30),
                      FieldContainer(title: 'Password', value: ''),
                    ],
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 55),
                backgroundColor: Colors.red[50],
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder:
                      (c) => AlertDialog(
                        title: const Text("Log Out"),
                        content: const Text(
                          "Are you sure you want to log out?",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () async {
                              SharedPreferences sharedPreferences =
                                  await SharedPreferences.getInstance();
                              sharedPreferences.clear();
                              context.go(Routes.login);
                            },
                            child: const Text(
                              "Confirm",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.logout, color: Colors.red),
                  const SizedBox(width: 8),
                  Text(
                    "Log Out",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.red[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
