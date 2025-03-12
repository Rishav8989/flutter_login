// lib/pages/my_service_provider_page.dart
import 'package:flutter/material.dart';

class MyServiceProviderPage extends StatelessWidget {
  const MyServiceProviderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Service Provider')),
      body: const Center(
        child: Text('My Service Provider Page Content'),
      ),
    );
  }
}