// lib/pages/declaration_page.dart
import 'package:flutter/material.dart';

class DeclarationPage extends StatelessWidget {
  const DeclarationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Declaration')),
      body: const Center(
        child: Text('Declaration Page Content'),
      ),
    );
  }
}