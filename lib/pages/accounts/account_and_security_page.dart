// lib/pages/account_and_security_page.dart
import 'package:flutter/material.dart';

class AccountAndSecurityPage extends StatelessWidget {
  const AccountAndSecurityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Account and Security')),
      body: const Center(
        child: Text('Account and Security Page Content'),
      ),
    );
  }
}