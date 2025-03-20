import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX

class LogoutConfirmationDialog {
  static Future<bool?> show() async { // Removed BuildContext context parameter
    return Get.dialog<bool>( // Replaced showDialog with Get.dialog
      AlertDialog(
        title: const Text('Confirm Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Get.back(result: false), // Cancel returns false, using Get.back
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),  // Logout returns true, using Get.back
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}