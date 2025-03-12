// lib/pages/website_page.dart
import 'package:flutter/material.dart';

class WebsitePage extends StatelessWidget {
  const WebsitePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Website')),
      body: const Center(
        child: Text('Website Page Content'),
      ),
    );
  }
}