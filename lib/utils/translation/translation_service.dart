// lib/translation_service.dart
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
    'Account': 'Account',
    // Additions from SupportPage.dart and AccountPage (Logout) and Bottom Navigation
    'Commissioning Tools': 'Commissioning Tools',
    'Local Access': 'Local Access',
    'WLAN Configuration': 'WLAN Configuration',
    'Firmware Download': 'Firmware Download',
    'Value-added Services': 'Value-added Services',
    'Live Data': 'Live Data',
    'Help Center': 'Help Center',
    'Feedback': 'Feedback',
    'Video Tutorial': 'Video Tutorial',
    'User Manual': 'User Manual',
    'FAQs': 'FAQs',
    'Support': 'Support', // AppBar Title and Bottom Nav label is 'Support'
    'logout': 'Logout', // For Logout Button in Account Page
    'Monitoring': 'Monitoring', // Bottom Navigation Label - Added again for clarity
    'Faults': 'Faults',        // Bottom Navigation Label - Added again for clarity
    'Support': 'Support',       // Bottom Navigation Label - Added again for clarity - already present, but added for completeness
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
    'Account': 'खाता',
    // Additions from SupportPage.dart and AccountPage (Logout) and Bottom Navigation
    'Commissioning Tools': 'कमिशनिंग टूल्स',
    'Local Access': 'स्थानीय पहुंच',
    'WLAN Configuration': 'WLAN कॉन्फ़िगरेशन',
    'Firmware Download': 'फर्मवेयर डाउनलोड',
    'Value-added Services': 'वैल्यू-एडेड सर्विसेज',
    'Live Data': 'लाइव डेटा',
    'Help Center': 'हेल्प सेंटर',
    'Feedback': 'प्रतिक्रिया',
    'Video Tutorial': 'वीडियो ट्यूटोरियल',
    'User Manual': 'उपयोगकर्ता पुस्तिका',
    'FAQs': 'सामान्य प्रश्न',
    'Support': 'समर्थन', // AppBar Title and Bottom Nav label is 'Support'
    'logout': 'लोग आउट', // For Logout Button in Account Page
    'Monitoring': 'निगरानी', // Bottom Navigation Label
    'Faults': 'दोष',        // Bottom Navigation Label
    'Support': 'समर्थन',       // Bottom Navigation Label
    'Account': 'खाता',       // Bottom Navigation Label
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
    // Additions from SupportPage.dart and AccountPage (Logout) and Bottom Navigation
    'Commissioning Tools': 'কমিশনিং সরঞ্জাম',
    'Local Access': 'স্থানীয় অ্যাক্সেস',
    'WLAN Configuration': 'WLAN কনফিগারেশন',
    'Firmware Download': 'ফার্মওয়্যার ডাউনলোড',
    'Value-added Services': 'মূল্য-সংযোজন পরিষেবা',
    'Live Data': 'লাইভ ডেটা',
    'Help Center': 'হেল্প সেন্টার',
    'Feedback': 'প্রতিক্রিয়া',
    'Video Tutorial': 'ভিডিও টিউটোরিয়াল',
    'User Manual': 'ইউজার ম্যানুয়াল',
    'FAQs': 'প্রায়শই জিজ্ঞাসিত প্রশ্নাবলী',
    'Support': 'সহায়তা', // AppBar Title and Bottom Nav label is 'Support'
    'logout': 'লগ আউট', // For Logout Button in Account Page
    'Monitoring': 'পর্যবেক্ষণ', // Bottom Navigation Label
    'Faults': 'ত্রুটি',        // Bottom Navigation Label
    'Support': 'সহায়তা',       // Bottom Navigation Label
    'Account': 'অ্যাকাউন্ট',       // Bottom Navigation Label
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
    // Additions from SupportPage.dart and AccountPage (Logout) and Bottom Navigation
    'Commissioning Tools': 'కమిషనింగ్ టూల్స్',
    'Local Access': 'స్థానిక యాక్సెస్',
    'WLAN Configuration': 'WLAN కాన్ఫిగరేషన్',
    'Firmware Download': 'ఫర్మ్‌వేర్ డౌన్‌లోడ్',
    'Value-added Services': 'విలువ-జోడించిన సేవలు',
    'Live Data': 'లైవ్ డేటా',
    'Help Center': 'సహాయ కేంద్రం',
    'Feedback': 'అభిప్రాయం',
    'Video Tutorial': 'వీడియో ట్యుటోరియల్',
    'User Manual': 'యూజర్ మాన్యువల్',
    'FAQs': 'తరచుగా అడిగే ప్రశ్నలు',
    'Support': 'మద్దతు', // AppBar Title and Bottom Nav label is 'Support'
    'logout': 'నిష్క్రమించు', // For Logout Button in Account Page
    'Monitoring': 'నిఘా', // Bottom Navigation Label
    'Faults': 'లోపాలు',        // Bottom Navigation Label
    'Support': 'మద్దతు',       // Bottom Navigation Label
    'Account': 'ఖాతా',       // Bottom Navigation Label
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
    // Additions from SupportPage.dart and AccountPage (Logout) and Bottom Navigation
    'Commissioning Tools': 'कमिशनिंग साधने',
    'Local Access': 'स्थानिक प्रवेश',
    'WLAN Configuration': 'WLAN कॉन्फिगरेशन',
    'Firmware Download': 'फर्मवेअर डाउनलोड',
    'Value-added Services': 'मूल्यवर्धित सेवा',
    'Live Data': 'लाइव्ह डेटा',
    'Help Center': 'मदत केंद्र',
    'Feedback': 'अभिप्राय',
    'Video Tutorial': 'व्हिडिओ ट्यूटोरियल',
    'User Manual': 'वापरकर्ता पुस्तिका',
    'FAQs': 'वारंवार विचारले जाणारे प्रश्न',
    'Support': 'आधार', // AppBar Title and Bottom Nav label is 'Support'
    'logout': 'Logout', // For Logout Button in Account Page - Marathi and English are same for Logout
    'Monitoring': 'निरीक्षण', // Bottom Navigation Label
    'Faults': 'दोष',        // Bottom Navigation Label
    'Support': 'आधार',       // Bottom Navigation Label
    'Account': 'खाते',       // Bottom Navigation Label
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
    // Additions from SupportPage.dart and AccountPage (Logout) and Bottom Navigation
    'Commissioning Tools': 'ஆணையிடும் கருவிகள்',
    'Local Access': 'உள்ளூர் அணுகல்',
    'WLAN Configuration': 'WLAN கட்டமைப்பு',
    'Firmware Download': 'நிலைபொருள் பதிவிறக்கம்',
    'Value-added Services': 'மதிப்பு கூட்டப்பட்ட சேவைகள்',
    'Live Data': 'நேரடி தரவு',
    'Help Center': 'உதவி மையம்',
    'Feedback': 'கருத்து',
    'Video Tutorial': 'வீடியோ பயிற்சி',
    'User Manual': 'பயனர் கையேடு',
    'FAQs': 'அடிக்கடி கேட்கப்படும் கேள்விகள்',
    'Support': 'ஆதரவு', // AppBar Title and Bottom Nav label is 'Support'
    'logout': 'வெளியேறு', // For Logout Button in Account Page
    'Monitoring': 'கண்காணிப்பு', // Bottom Navigation Label
    'Faults': 'குறைபாடுகள்',        // Bottom Navigation Label
    'Support': 'ஆதரவு',       // Bottom Navigation Label
    'Account': 'கணக்கு',       // Bottom Navigation Label
  }
};