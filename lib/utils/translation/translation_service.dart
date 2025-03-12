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
  Map<String, Map<String, String>> get keys => translations;
}

final Map<String, Map<String, String>> translations = {
  'en': {
    'view_profile': 'View Profile',
    'account_security': 'Account and Security',
    'general': 'General',
    'service_provider': 'My Service Provider',
    'website': 'Website',
    'notifications': 'Notifications',
    'reports': 'Reports',
    'app_sharing': 'Application Sharing',
    'declaration': 'Declaration',
    'about': 'About',
    'monitoring': 'Monitoring',
    'faults': 'Faults',
    'support': 'Support',
    'account': 'Account',
  },
  'hi': {
    'view_profile': 'प्रोफ़ाइल देखें',
    'account_security': 'खाता और सुरक्षा',
    'general': 'सामान्य',
    'service_provider': 'मेरे सेवा प्रदाता',
    'website': 'वेबसाइट',
    'notifications': 'सूचनाएँ',
    'reports': 'रिपोर्ट्स',
    'app_sharing': 'एप्लिकेशन साझाकरण',
    'declaration': 'घोषणा',
    'about': 'बारे में',
    'monitoring': 'निगरानी',
    'faults': 'दोष',
    'support': 'समर्थन',
    'account': 'खाता',
  },
  'bn': {
    'view_profile': 'প্রোফাইল দেখুন',
    'account_security': 'অ্যাকাউন্ট ও নিরাপত্তা',
    'general': 'সাধারণ',
    'service_provider': 'আমার পরিষেবা প্রদানকারী',
    'website': 'ওয়েবসাইট',
    'notifications': 'বিজ্ঞপ্তি',
    'reports': 'রিপোর্ট',
    'app_sharing': 'অ্যাপ শেয়ারিং',
    'declaration': 'ঘোষণা',
    'about': 'পরিচিতি',
    'monitoring': 'পর্যবেক্ষণ',
    'faults': 'ত্রুটি',
    'support': 'সহায়তা',
    'account': 'অ্যাকাউন্ট',
  },
  'te': {
    'view_profile': 'ప్రొఫైల్ చూడండి',
    'account_security': 'ఖాతా మరియు భద్రత',
    'general': 'సాధారణ',
    'service_provider': 'నా సేవా ప్రదాత',
    'website': 'వెబ్‌సైట్',
    'notifications': 'నోటిఫికేషన్‌లు',
    'reports': 'నివేదికలు',
    'app_sharing': 'యాప్ పంచుకోడం',
    'declaration': 'ప్రకటన',
    'about': 'గురించి',
    'monitoring': 'నిఘా',
    'faults': 'లోపాలు',
    'support': 'మద్దతు',
    'account': 'ఖాతా',
  },
  'mr': {
    'view_profile': 'प्रोफाइल पहा',
    'account_security': 'खाते आणि सुरक्षा',
    'general': 'सामान्य',
    'service_provider': 'माझा सेवा प्रदाता',
    'website': 'वेबसाइट',
    'notifications': 'सूचना',
    'reports': 'अहवाल',
    'app_sharing': 'अॅप शेअरिंग',
    'declaration': 'घोषणा',
    'about': 'विषयी',
    'monitoring': 'निरीक्षण',
    'faults': 'दोष',
    'support': 'आधार',
    'account': 'खाते',
  },
  'ta': {
    'view_profile': 'சுயவிவரத்தை பார்க்கவும்',
    'account_security': 'கணக்கு மற்றும் பாதுகாப்பு',
    'general': 'பொது',
    'service_provider': 'என் சேவை வழங்குபவர்',
    'website': 'இணையதளம்',
    'notifications': 'அறிவிப்புகள்',
    'reports': 'அறிக்கைகள்',
    'app_sharing': 'பயன்பாடு பகிர்வு',
    'declaration': 'அறிக்கை',
    'about': 'பற்றி',
    'monitoring': 'கண்காணிப்பு',
    'faults': 'குறைபாடுகள்',
    'support': 'ஆதரவு',
    'account': 'கணக்கு',
  }
};