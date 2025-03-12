import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TranslationService extends Translations {
  static const fallbackLocale = Locale('en', 'US'); // Default locale if translation not found
  static const supportedLocales = [
    Locale('en', 'US'), // English
    Locale('hi', 'IN'), // Hindi
    Locale('bn', 'IN'), // Bengali
    Locale('te', 'IN'), // Telugu
    Locale('mr', 'IN'), // Marathi
    Locale('ta', 'IN'), // Tamil
  ];

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enUS, // English translations
        'hi_IN': hiIN, // Hindi translations
        'bn_IN': bnIN, // Bengali translations
        'te_IN': teIN, // Telugu translations
        'mr_IN': mrIN, // Marathi translations
        'ta_IN': taIN, // Tamil translations
      };
}

// English translations (en_US)
const Map<String, String> enUS = {
  'appName': 'My App',
  'hello': 'Hello',
  'Solar Square': 'Solar Square',
};

// Hindi translations (hi_IN)
const Map<String, String> hiIN = {
  'appName': 'मेरा ऐप',
  'hello': 'नमस्ते',
  'Solar Square': 'सोलर स्क्वेयर',
};

// Bengali translations (bn_IN)
const Map<String, String> bnIN = {
  'appName': 'আমার অ্যাপ',
  'hello': 'নমস্কার',
  'Solar Square': 'সোলার স্কোয়ার',
};

// Telugu translations (te_IN)
const Map<String, String> teIN = {
  'appName': 'నా యాప్',
  'hello': 'నమస్కారం',
  'Solar Square': 'సోలార్ స్క్వేర్',
};

// Marathi translations (mr_IN)
const Map<String, String> mrIN = {
  'appName': 'माझे अॅप',
  'hello': 'नमस्कार',
  'Solar Square': 'सोलार स्क्वेअर',
};

// Tamil translations (ta_IN)
const Map<String, String> taIN = {
  'appName': 'என் பயன்பாடு',
  'hello': 'வணக்கம்',
  'Solar Square': 'சோலார் ஸ்கொயர்',
};
