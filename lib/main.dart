import 'package:flutter/material.dart';
import 'package:login/utils/app_theme.dart';
import 'login_page.dart';
import 'home_page.dart'; // Import HomePage
import 'package:pocketbase/pocketbase.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences

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
      theme: darkTheme,       // Use appTheme from app_theme.dart
      // Remove darkTheme and themeMode as you are using only default theme
      debugShowCheckedModeBanner: false,
      home: const AuthCheck(),
    );
  }
}

class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  Future<String?> _getCachedToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('pb_auth_token');
  }

  Future<void> _loadCachedToken() async {
    final cachedToken = await _getCachedToken();
    if (cachedToken != null) {
      pb.authStore.save(cachedToken, pb.authStore.record);
      print('Cached token loaded.');
    } else {
      print('No cached token found.');
    }
  }

  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    await _loadCachedToken();
    await Future.delayed(Duration.zero);

    if (pb.authStore.isValid) {
      print('User is already logged in (Token: ${pb.authStore.token})');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      print('User is not logged in.');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}