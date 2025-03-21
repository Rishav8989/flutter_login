import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/login_page.dart';
import 'package:login/utils/auth/logout_confirmation_dialog.dart';
import 'package:login/main.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  void _logout() async {
    bool? confirmLogout = await LogoutConfirmationDialog.show();

    if (confirmLogout == true) {
      pb.authStore.clear();
      print('Logged out!');
      Get.offAll(() => const LoginPage());
    } else if (confirmLogout == false) {
      print('Logout cancelled');
      Get.snackbar(
        'Logout cancelled',
        'Logout cancelled',
        duration: const Duration(seconds: 2),
      );
    } else {
      print('Logout dialog dismissed without choice');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: FractionallySizedBox(
        widthFactor: 0.3,
        child: SizedBox(
          height: 50.0,
          child: ElevatedButton(
            onPressed: _logout,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: Text(
              'Logout'.tr,
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}