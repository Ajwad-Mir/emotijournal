import 'dart:math';

import 'package:flutter/material.dart';

class AppColors {
  static final AppColors instance = AppColors._();

  factory AppColors() {
    return instance;
  }

  AppColors._();

  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color darkTextColor = Color(0xFFFFFFFF);
  static const Color lightTextColor = Color(0xFF000000);
  static const Color lightBackgroundColor = Color(0xFFFFFFFF);
  static const Color darkBackgroundColor = Color(0xFF202020);
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [
      Color(0xFF00DA89),
      Color(0xFF2BCEEF),
    ],
    stops: [
      0.0,
      1.0,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );


  static Color getRandomColor() {
    Color color;
    do {
      int red = Random().nextInt(200); // Avoid very high values
      int green = Random().nextInt(200);
      int blue = Random().nextInt(200);
      color = Color.fromRGBO(red, green, blue, 1);
    } while (color == Colors.white || color == Colors.grey[100]); // Avoid white and very light grey
    return color;
  }
}
