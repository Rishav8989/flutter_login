// utils/theme_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_theme.dart'; // Import your theme definitions

enum AppTheme {
  light,
  dark,
  amoled,
}

class ThemeController extends GetxController {
  final _currentTheme = AppTheme.light.obs; // Start with light theme by default

  AppTheme get currentTheme => _currentTheme.value;

  ThemeMode get themeMode {
    switch (_currentTheme.value) {
      case AppTheme.light:
        return ThemeMode.light;
      case AppTheme.dark:
      case AppTheme.amoled: // Treat both dark and amoled as dark modes for ThemeMode
        return ThemeMode.dark;
      default:
        return ThemeMode.light; // Default to light if something goes wrong
    }
  }

  ThemeData get themeData {
    switch (_currentTheme.value) {
      case AppTheme.light:
        return lightTheme;
      case AppTheme.dark:
        return darkTheme;
      case AppTheme.amoled:
        return amoled;
      default:
        return lightTheme; // Default to light if something goes wrong
    }
  }

  void setTheme(AppTheme theme) {
    _currentTheme.value = theme;
    Get.changeTheme(themeData); // Update the app's theme using GetX
    Get.changeThemeMode(themeMode); // Update the theme mode as well
  }

  void switchToLightTheme() => setTheme(AppTheme.light);
  void switchToDarkTheme() => setTheme(AppTheme.dark);
  void switchToAmoledTheme() => setTheme(AppTheme.amoled);
}