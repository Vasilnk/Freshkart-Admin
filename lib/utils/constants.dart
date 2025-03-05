import 'package:flutter/material.dart';

class Constants {
  // SharedPreferences sharedPreferences =  SharedPreferences.getInstance();
  static Color greenColor = Color.fromARGB(255, 70, 151, 100);
  static Map<Color, Color> colors = {
    Color.fromARGB(255, 226, 253, 232): Color.fromARGB(199, 111, 197, 140),
    Color.fromARGB(255, 246, 228, 228): Color.fromARGB(255, 241, 162, 162),
    Color.fromARGB(255, 255, 242, 229): Color.fromARGB(255, 243, 153, 88),
  };
  static List<String> addItems = ['Products', 'Cover Images', 'Offer Products'];
  static ButtonStyle bigButton = ElevatedButton.styleFrom(
    minimumSize: Size(330, 67),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    backgroundColor: greenColor,
  );
  static TextStyle bigButtonTextStyle = TextStyle(color: Colors.white, fontSize: 20);

  static const String logoImage = 'assets/images/F icon.png';
  static const String loginImage = 'assets/images/loginImage.png';
  static const Map<String, String> categories = {
    'vegetables': 'assets/images/vegetable.png',
    'fruits': 'assets/images/fruits.png',
    'Diary': 'assets/images/fruits.png',
  };
}
