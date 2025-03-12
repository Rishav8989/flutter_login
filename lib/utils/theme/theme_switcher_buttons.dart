import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/utils/theme/theme_controller.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();

    return Obx(() {
      bool isDarkMode = themeController.currentTheme == AppTheme.dark;
      return IconButton(
        icon: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
        tooltip: isDarkMode ? 'Switch to Light Mode' : 'Switch to Dark Mode',
        onPressed: () {
          isDarkMode
              ? themeController.switchToLightTheme()
              : themeController.switchToDarkTheme();
        },
      );
    });
  }
}
