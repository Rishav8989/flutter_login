// main.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/utils/auth/auth_check.dart';
import 'package:login/utils/splash_screen.dart';
import 'package:login/utils/theme/app_theme.dart';
import 'package:login/utils/theme/theme_controller.dart';
import 'package:login/utils/translation/locale_controller.dart';
import 'package:login/utils/translation/translation_service.dart';
import 'package:pocketbase/pocketbase.dart';

final pb = PocketBase('https://first.pockethost.io/');

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final ThemeController themeController = Get.put(ThemeController());
  await themeController.loadInitialTheme();

  final LocaleController localeController = Get.put(LocaleController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();
    final LocaleController localeController = Get.find<LocaleController>();

    return Obx(() => GetMaterialApp(
      title: 'Flutter Notes App'.tr,
      translations: TranslationService(),
      locale: localeController.currentLocale,
      fallbackLocale: TranslationService.fallbackLocale,
      theme: themeController.themeData,
      darkTheme: darkTheme,
      themeMode: themeController.themeMode,
      debugShowCheckedModeBanner: false,
      home: const SplashScreenWrapper(), // Use SplashScreenWrapper as home
    ));
  }
}

class SplashScreenWrapper extends StatefulWidget {
  const SplashScreenWrapper({super.key});

  @override
  State<SplashScreenWrapper> createState() => _SplashScreenWrapperState();
}

class _SplashScreenWrapperState extends State<SplashScreenWrapper> {
  bool _loading = true; // Track loading state, initially true

  @override
  void initState() {
    super.initState();
    _removeSplashScreen(); // Call function to remove splash screen immediately
  }

  void _removeSplashScreen() {
    setState(() {
      _loading = false; // Set loading to false immediately to remove splash screen
    });
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? const SplashScreen() // Show SplashScreen while loading (initially)
        : const AuthCheck();   // Show AuthCheck when not loading (immediately after build)
  }
}