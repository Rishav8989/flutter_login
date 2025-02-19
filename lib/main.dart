import 'package:flutter/material.dart';
import 'package:login/utils/app_theme.dart';
import 'package:login/utils/auth_check.dart';
import 'package:pocketbase/pocketbase.dart';

final pb = PocketBase('https://first.pockethost.io/');

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Notes App',
      theme: amoled, // Directly using lightTheme
      themeMode: ThemeMode.system, // Keep or remove themeMode based on if you want system theme or always light
      debugShowCheckedModeBanner: false,
      home: const AuthCheck(),
    );
  }
}