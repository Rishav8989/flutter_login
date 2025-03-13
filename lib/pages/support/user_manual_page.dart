// lib/pages/support/user_manual_page.dart
import 'package:flutter/material.dart';

class UserManualPage extends StatelessWidget {
  const UserManualPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Manual'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('User Manual Page Content'),
      ),
    );
  }
}