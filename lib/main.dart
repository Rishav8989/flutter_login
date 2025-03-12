// main.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/utils/auth/auth_check.dart';
import 'package:login/utils/theme/app_theme.dart';
import 'package:login/utils/theme/theme_controller.dart';
import 'package:pocketbase/pocketbase.dart';

final pb = PocketBase('https://first.pockethost.io/');

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.put(ThemeController());

    return Obx(() => GetMaterialApp( // Wrap GetMaterialApp with Obx
      title: 'Flutter Notes App',
      theme: themeController.themeData, // Use themeData from ThemeController
      darkTheme: darkTheme, // You can still define a default darkTheme if needed for system mode
      themeMode: themeController.themeMode, // Use themeMode from ThemeController
      debugShowCheckedModeBanner: false,
      home: const AuthCheck(),
    ));
  }
}