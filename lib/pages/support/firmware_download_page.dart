// lib/pages/support/firmware_download_page.dart
import 'package:flutter/material.dart';

class FirmwareDownloadPage extends StatelessWidget {
  const FirmwareDownloadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firmware Download'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Firmware Download Page Content'),
      ),
    );
  }
}