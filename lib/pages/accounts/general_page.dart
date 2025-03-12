// lib/pages/general_page.dart
import 'package:flutter/material.dart';

class GeneralPage extends StatelessWidget {
  const GeneralPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('General')),
      body: const Center(
        child: Text('General Page Content'),
      ),
    );
  }
}