import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/utils/theme/theme_controller.dart';

class ThemeSwitcherButtons extends StatelessWidget {
  const ThemeSwitcherButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find(); // Get the ThemeController

    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.light_mode),
          tooltip: 'Light Theme',
          onPressed: () {
            themeController.switchToLightTheme();
          },
        ),
        IconButton(
          icon: const Icon(Icons.dark_mode),
          tooltip: 'Dark Theme',
          onPressed: () {
            themeController.switchToDarkTheme();
          },
        ),
      ],
    );
  }
}