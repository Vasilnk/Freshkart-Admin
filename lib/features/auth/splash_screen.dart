import 'dart:async';

import 'package:flutter/material.dart';
import 'package:freshkart_admin/main.dart';
import 'package:freshkart_admin/utils/colors.dart';
import 'package:freshkart_admin/utils/images.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () async {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final isLogged = sharedPreferences.getBool('isLogged');
      context.replace(isLogged == true ? Routes.landing : Routes.login);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 160,
              width: 160,
              child: Image.asset(AppImages.logoImage),
            ),
            Text(
              'Admin  ',
              style: GoogleFonts.abrilFatface(
                textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: AppColors.greenColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
