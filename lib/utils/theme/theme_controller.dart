// utils/theme_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/utils/theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppTheme {
  light,
  dark,
}

class ThemeController extends GetxController {
  final _currentTheme = AppTheme.light.obs;
  late SharedPreferences _prefs;
  final String _themeKey = 'app_theme';
  bool _isThemeLoaded = false;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> loadInitialTheme() async {
    await _loadThemeFromPreferences();
    _isThemeLoaded = true;
  }

  AppTheme get currentTheme => _currentTheme.value;

  ThemeMode get themeMode {
    if (!_isThemeLoaded) return ThemeMode.system;
    return _currentTheme.value == AppTheme.dark 
        ? ThemeMode.dark 
        : ThemeMode.light;
  }

  ThemeData get themeData {
    return _currentTheme.value == AppTheme.dark 
        ? darkTheme 
        : lightTheme;
  }

  Future<void> setTheme(AppTheme theme) async {
    _currentTheme.value = theme;
    await _saveThemeToPreferences(theme);
  }

  void switchToLightTheme() => setTheme(AppTheme.light);
  void switchToDarkTheme() => setTheme(AppTheme.dark);

  Future<void> _loadThemeFromPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    String? themeName = _prefs.getString(_themeKey);
    
    if (themeName != null) {
      try {
        _currentTheme.value = AppTheme.values.byName(themeName);
      } catch (e) {
        print('Error loading theme: $e');
      }
    }
  }

  Future<void> _saveThemeToPreferences(AppTheme theme) async {
    _prefs = await SharedPreferences.getInstance();
    await _prefs.setString(_themeKey, theme.name);
  }
}