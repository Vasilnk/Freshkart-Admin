import 'package:flutter/material.dart';
import 'package:freshkart_admin/utils/colors.dart';

class AppStyles {
  static ButtonStyle greenElevatedButton = ElevatedButton.styleFrom(
    minimumSize: Size(double.infinity, 67),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    backgroundColor: AppColors.greenColor,
  );
  static TextStyle bigButtonTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 20,
  );

  static ButtonStyle redElevatedButtonStyle = ElevatedButton.styleFrom(
    minimumSize: Size(double.infinity, 67),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    backgroundColor: AppColors.deleteButtonColor,
  );
  static TextStyle elevatedButtonTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
  static TextStyle redelevatedButtonTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: Colors.red.shade500,
  );
  static TextStyle mediumTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
}
