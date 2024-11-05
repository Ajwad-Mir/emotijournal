import 'dart:ui';

class OptionModel {
  final String text;
  final String icon;
  final VoidCallback onPressed;

  OptionModel({required this.text, required this.icon, required this.onPressed});
}