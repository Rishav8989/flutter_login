import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/utils/theme/theme_switcher_buttons.dart';
import 'package:login/utils/translation/language_selector.dart';
import 'package:login/utils/auth/logout_button.dart';

class HomeAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'Solar Square'.tr, // Using translation for App Name
      ),
      centerTitle: true,
      actions: <Widget>[
        const LanguageSelector(),
        const SizedBox(width: 12), // Spacing
        const ThemeToggleButton(),
        const SizedBox(width: 12), // Spacing
        const LogoutButton(),
        const SizedBox(width: 8), // Extra spacing at the end for balance
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
