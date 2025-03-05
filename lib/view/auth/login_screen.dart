import 'package:flutter/material.dart';
import 'package:freshkart_admin/core/constants.dart';
import 'package:freshkart_admin/view/screens/landing_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final idController = TextEditingController();
  final passwordController = TextEditingController();
  final loginKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(Constants.loginImage),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.40),
                  Text(
                    'Sign in',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 20),
                  Form(
                    key: loginKey,
                    child: Column(
                      spacing: 13,
                      children: [
                        TextFormField(
                          controller: idController,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'enter Admin id';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Admin Id',
                            labelStyle: TextStyle(color: Colors.grey),

                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                        TextFormField(
                          controller: passwordController,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'password is requred';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            labelText: 'Password',
                            labelStyle: TextStyle(color: Colors.grey),
                            suffixIcon: Icon(Icons.remove_red_eye),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [Text('forget password?')],
                  ),
                  SizedBox(height: 35),

                  ElevatedButton(
                    onPressed: () async {
                      if (loginKey.currentState!.validate()) {
                        try {
                          final data =
                              await FirebaseFirestore.instance
                                  .collection('admin')
                                  .doc('FOKZ08SXgwEkwNMVqn55')
                                  .get();
                          String id = data['adminId'];
                          String password = data['password'];

                          if (id == idController.text.trim() &&
                              password == passwordController.text.trim()) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LandingScreen(),
                              ),
                            );
                            SharedPreferences sharedPreferences =
                                await SharedPreferences.getInstance();
                            sharedPreferences.setBool('isLogged', true);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Incorrect admin ID or password'),
                              ),
                            );
                          }
                        } on FirebaseException catch (e) {
                          print(e);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                e.message!.split(' ').first.toString(),
                              ),
                            ),
                          );
                        }
                      }
                    },
                    style: Constants.bigButton,
                    child: Text('Sign in', style: Constants.bigButtonTextStyle),
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
