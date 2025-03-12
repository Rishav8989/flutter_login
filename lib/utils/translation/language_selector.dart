import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/utils/translation/locale_controller.dart';
import 'package:login/utils/translation/translation_service.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final LocaleController localeController = Get.find<LocaleController>();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0), // Internal padding
      decoration: BoxDecoration(
        color: Theme.of(context).appBarTheme.backgroundColor, // Match AppBar color
        borderRadius: BorderRadius.circular(8.0), // Rounded corners
      ),
      child: DropdownButtonHideUnderline( // Hide default underline
        child: DropdownButton<Locale>(
          value: TranslationService.supportedLocales.contains(localeController.currentLocale)
              ? localeController.currentLocale
              : TranslationService.fallbackLocale, // Ensure value is valid
          icon: const Icon(Icons.language, color: Colors.white),
          dropdownColor: Theme.of(context).appBarTheme.backgroundColor,
          style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color),
          items: TranslationService.supportedLocales.map((Locale locale) {
            return DropdownMenuItem<Locale>(
              value: locale,
              child: Text(
                _getLanguageName(locale),
                style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color),
              ),
            );
          }).toList(),
          onChanged: (Locale? newLocale) {
            if (newLocale != null) {
              localeController.setLocale(newLocale);
            }
          },
        ),
      ),
    );
  }

  /// **Helper function to get proper language names**
  String _getLanguageName(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return 'English';
      case 'hi':
        return 'हिन्दी (Hindi)';
      case 'bn':
        return 'বাংলা (Bengali)';
      case 'te':
        return 'తెలుగు (Telugu)';
      case 'mr':
        return 'मराठी (Marathi)';
      case 'ta':
        return 'தமிழ் (Tamil)';
      default:
        return locale.languageCode.toUpperCase();
    }
  }
}
