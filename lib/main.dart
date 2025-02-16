import 'package:flutter/material.dart';
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
      title: 'Flutter PocketBase Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const AuthCheck(), // Use AuthCheck widget as the initial home
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
      pb.authStore.save(cachedToken, pb.authStore.model); // Load token into authStore
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
    await _loadCachedToken(); // Try to load cached token first
    // Wait for the auth store to be initialized (important on app start)
    await Future.delayed(Duration.zero); // Ensures build context is available


    if (pb.authStore.isValid) {
      print('User is already logged in (Token: ${pb.authStore.token})');
      // Navigate directly to HomePage if already logged in
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      print('User is not logged in.');
      // Navigate to LoginPage if not logged in
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // You can show a loading indicator here while checking auth state
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}