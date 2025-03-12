// lib/pages/application_sharing_page.dart
import 'package:flutter/material.dart';

class ApplicationSharingPage extends StatelessWidget {
  const ApplicationSharingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Application Sharing')),
      body: const Center(
        child: Text('Application Sharing Page Content'),
      ),
    );
  }
}