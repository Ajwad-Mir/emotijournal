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
  static const Color darkBackgroundColor = Color(0xFF111111);
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [
      Color(0xFF00DA89),
      Color(0xFF2BCEEF),
    ],
    stops: [
      0,
      1,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
