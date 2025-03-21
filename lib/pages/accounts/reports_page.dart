// lib/pages/reports_page.dart
import 'package:flutter/material.dart';
import 'package:login/widgets/detailed_chart.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reports')),
      body: const Center(
        child: DetailedChart(),
      ),
    );
  }
}