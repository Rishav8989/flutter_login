// lib/pages/support/wlan_configuration_page.dart
import 'package:flutter/material.dart';

class WLANConfigurationPage extends StatelessWidget {
  const WLANConfigurationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WLAN Configuration'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('WLAN Configuration Page Content'),
      ),
    );
  }
}