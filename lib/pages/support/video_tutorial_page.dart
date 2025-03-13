// lib/pages/support/video_tutorial_page.dart
import 'package:flutter/material.dart';

class VideoTutorialPage extends StatelessWidget {
  const VideoTutorialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Tutorial'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Video Tutorial Page Content'),
      ),
    );
  }
}