// lib/pages/support/feedback_page.dart
import 'package:flutter/material.dart';

class FeedbackPage extends StatelessWidget {
  const FeedbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Feedback Page Content'),
      ),
    );
  }
}