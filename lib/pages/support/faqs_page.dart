// lib/pages/support/faqs_page.dart
import 'package:flutter/material.dart';

class FAQsPage extends StatelessWidget {
  const FAQsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FAQs'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('FAQs Page Content'),
      ),
    );
  }
}