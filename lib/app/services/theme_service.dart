import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeService extends GetxController {
  final _storage = GetStorage();
  final _themeKey = 'themeMode';

  // Observable theme mode
  final _themeMode = ThemeMode.system.obs;

  ThemeMode get themeMode => _themeMode.value;

  @override
  void onInit() {
    super.onInit();
    // Load saved theme mode when service initializes
    _loadThemeMode();
  }

  // Load theme from storage
  void _loadThemeMode() {
    final savedMode = _storage.read(_themeKey);
    if (savedMode != null) {
      _themeMode.value = ThemeMode.values.firstWhere(
        (mode) => mode.toString() == savedMode,
        orElse: () => ThemeMode.system,
      );
    }
  }
}
