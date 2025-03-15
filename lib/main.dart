import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/utils/auth/auth_check.dart';
import 'package:login/utils/splash_screen.dart';
import 'package:login/utils/theme/theme_controller.dart';
import 'package:login/utils/translation/locale_controller.dart';
import 'package:login/utils/translation/translation_service.dart';
import 'package:pocketbase/pocketbase.dart';

final pb = PocketBase('https://first.pockethost.io/');

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final themeController = Get.put(ThemeController());
  await themeController.loadInitialTheme();

  final localeController = Get.put(LocaleController());

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