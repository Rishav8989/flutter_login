import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/utils/auth/auth_check.dart';
import 'package:login/utils/theme/app_theme.dart';
import 'package:login/utils/theme/theme_controller.dart';
import 'package:pocketbase/pocketbase.dart';

final pb = PocketBase('https://first.pockethost.io/');

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final ThemeController themeController = Get.put(ThemeController());
  await themeController.loadInitialTheme();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();

    return Obx(() => GetMaterialApp(
      title: 'Flutter Notes App',
      theme: themeController.themeData,
      darkTheme: darkTheme,
      themeMode: themeController.themeMode,
      debugShowCheckedModeBanner: false,
      home: const AuthCheck(),
    ));
  }
}