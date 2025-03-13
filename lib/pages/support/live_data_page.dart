// lib/pages/support/live_data_page.dart
import 'package:flutter/material.dart';

class LiveDataPage extends StatelessWidget {
  const LiveDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Data'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Live Data Page Content'),
      ),
    );
  }
}