import 'package:flutter/material.dart';
import 'package:freshkart_admin/main.dart';
import 'package:freshkart_admin/services/admin_services.dart';
import 'package:freshkart_admin/utils/images.dart';
import 'package:freshkart_admin/utils/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freshkart_admin/widgets/text_form_filed.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final idController = TextEditingController();
  final passwordController = TextEditingController();
  final loginKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final isWeb = MediaQuery.of(context).size.width > 600;
    return Scaffold(
      body:
          isWeb
              ? buildWebLayout(context)
              : Stack(
                children: [
                  Image.asset(AppImages.loginImage),
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.40,
                          ),
                          Text(
                            'Sign in',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 20),
                          Form(
                            key: loginKey,
                            child: Column(
                              spacing: 13,
                              children: [
                                CustomTextFormField(
                                  label: 'Admin Id',
                                  controller: idController,
                                ),
                                CustomTextFormField(
                                  label: 'Password',
                                  controller: passwordController,
                                  isPasswordField: true,
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
                            onPressed: () => adminValidate(context),
                            style: AppStyles.greenElevatedButton,
                            child: Text(
                              'Sign in',
                              style: AppStyles.bigButtonTextStyle,
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

  Widget buildWebLayout(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          AppImages.loginImage,
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
        ),
        Center(
          child: LayoutBuilder(
            builder: (context, constants) {
              double containerWidth = 400;
              if (constants.maxWidth > 800) {
                containerWidth = 600;
              }
              return Container(
                width: containerWidth,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [BoxShadow(blurRadius: 12, color: Colors.black12)],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Sign in',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 20),
                    Form(
                      key: loginKey,
                      child: Column(
                        children: [
                          CustomTextFormField(
                            label: 'Admin Id',
                            controller: idController,
                          ),
                          CustomTextFormField(
                            label: 'Password',
                            controller: passwordController,
                            isPasswordField: true,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [Text('Forget password?')],
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () => adminValidate(context),
                      style: AppStyles.greenElevatedButton,
                      child: Text(
                        'Sign in',
                        style: AppStyles.bigButtonTextStyle,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  adminValidate(BuildContext context) async {
    final adminServices = AdminServices();
    if (loginKey.currentState!.validate()) {
      try {
        final data = await adminServices.fatchAdmin();
        String id = data?['adminId'];
        String password = data?['password'];

        if (id == idController.text.trim() &&
            password == passwordController.text.trim()) {
          context.replace(Routes.landing);

          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          sharedPreferences.setBool('isLogged', true);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Incorrect admin ID or password')),
          );
        }
      } on FirebaseException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message!.split(' ').first.toString())),
        );
      }
    }
  }
}
