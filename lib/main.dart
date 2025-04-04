import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/utils/auth/auth_check.dart';
import 'package:login/utils/splash_screen.dart';
import 'package:login/utils/theme/theme_controller.dart';
import 'package:login/utils/translation/locale_controller.dart';
import 'package:login/utils/translation/translation_service.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // Add this import

late PocketBase pb; // Declare pb as late

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Load environment variables
  await dotenv.load(fileName: ".env");
  
  final themeController = Get.put(ThemeController());
  await themeController.loadInitialTheme();

  final localeController = Get.put(LocaleController());
  
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  // Initialize PocketBase after loading environment variables
  pb = PocketBase(dotenv.env['POCKETBASE_URL'] ?? 'https://default.url'); // Add a fallback URL
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();
    final LocaleController localeController = Get.find();

    return Obx(() => GetMaterialApp(
      title: 'Solar'.tr,
      translations: TranslationService(),
      locale: localeController.currentLocale,
      fallbackLocale: TranslationService.fallbackLocale,
      theme: themeController.themeData,
      darkTheme: themeController.themeData,
      themeMode: themeController.themeMode,
      debugShowCheckedModeBanner: false,
      home: const SplashScreenWrapper(),
    ));
  }
}

class SplashScreenWrapper extends StatefulWidget {
  const SplashScreenWrapper({super.key});

  @override
  State<SplashScreenWrapper> createState() => _SplashScreenWrapperState();
}

class _SplashScreenWrapperState extends State<SplashScreenWrapper> {
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _removeSplashScreen();
  }

  void _removeSplashScreen() {
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _loading ? const SplashScreen() : const AuthCheck();
  }
}