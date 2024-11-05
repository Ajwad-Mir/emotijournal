import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeService extends GetxController {
  final _themeKey = 'themeMode';


  // Observable theme mode
  final currentThemeMode = ThemeMode.system.obs;

  @override
  void onInit() {
    super.onInit();
    // Load saved theme mode when service initializes
    _loadThemeMode();
  }

  // Load theme from storage
  void _loadThemeMode() {
    final savedMode = GetStorage().read(_themeKey);
    if (savedMode != null) {
      currentThemeMode.value = ThemeMode.values.firstWhere(
        (mode) => mode.toString() == savedMode,
        orElse: () => ThemeMode.system,
      );
    }
  }

  void changeTheme(ThemeMode selectedTheme) async{
    if(currentThemeMode.value == selectedTheme) {
      return;
    }
    currentThemeMode.value = selectedTheme;
    Get.changeThemeMode(selectedTheme);
    await GetStorage().write(_themeKey,currentThemeMode.value.toString());
  }
}
