// lib/controllers/locale_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/utils/translation/translation_service.dart';
import 'package:shared_preferences/shared_preferences.dart'; // For persistence

class LocaleController extends GetxController {
  final _currentLocale = Rx<Locale>(TranslationService.fallbackLocale); // **Corrected line - access static member directly**
  late SharedPreferences _prefs;
  final String _localeKey = 'app_locale'; // Key for storing locale in SharedPreferences

  @override
  void onInit() {
    super.onInit();
    _loadLocaleFromPreferences(); // Load locale when controller is initialized
  }

  Locale get currentLocale => _currentLocale.value;

  Future<void> setLocale(Locale locale) async {
    _currentLocale.value = locale;
    Get.updateLocale(locale); // Update GetX locale
    await _saveLocaleToPreferences(locale); // Persist locale
  }

  void changeLocale(String languageCode, String countryCode) {
    final locale = Locale(languageCode, countryCode);
    setLocale(locale);
  }

  // Load locale from SharedPreferences
  Future<void> _loadLocaleFromPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    String? localeString = _prefs.getString(_localeKey);
    if (localeString != null) {
      List<String> parts = localeString.split('_');
      if (parts.length == 2) {
        try {
          final savedLocale = Locale(parts[0], parts[1]);
          _currentLocale.value = savedLocale;
          Get.updateLocale(savedLocale); // Apply locale immediately
        } catch (e) {
          print('Error loading locale: $e');
          // Fallback to default if loading fails
          _currentLocale.value = TranslationService.fallbackLocale; // **Corrected line here as well (for fallback)**
          Get.updateLocale(TranslationService.fallbackLocale); // **Corrected line here as well (for fallback)**
        }
      }
    }
    // If no locale is saved, it will default to the initial value (fallbackLocale)
  }

  // Save locale to SharedPreferences
  Future<void> _saveLocaleToPreferences(Locale locale) async {
    _prefs = await SharedPreferences.getInstance();
    await _prefs.setString(_localeKey, '${locale.languageCode}_${locale.countryCode}');
  }
}