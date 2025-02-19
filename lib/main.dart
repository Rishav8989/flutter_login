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
      title: 'Flutter Notes App',
      theme: ThemeData(
        primarySwatch: Colors.blue, // Primary color is blue for light theme
        primaryColor: Colors.blue, // Ensure primaryColor is blue
        textTheme: const TextTheme( // Customize default text color for light theme if needed
          bodyMedium: TextStyle(color: Colors.black87), // Example: Default text color is dark grey in light theme
          // You can customize other text styles here for light theme
        ),
        elevatedButtonTheme: ElevatedButtonThemeData( // Style for ElevatedButton in light theme
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue, // Button background color is blue
            foregroundColor: Colors.white, // Button text color is white
          ),
        ),
        // You can customize other parts of the light theme if needed
      ),
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.grey[900],
        primaryColor: Colors.blue, // Ensure primaryColor is blue in dark theme as well if you want blue accents
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black87,
          titleTextStyle: TextStyle(
            color: Colors.white,
          ),
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white), // Default text color is white in dark theme
          // You can customize other text styles here for dark theme
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.blue, // FAB background is blue
          foregroundColor: Colors.white, // FAB icon color is white
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        elevatedButtonTheme: ElevatedButtonThemeData( // Style for ElevatedButton in dark theme
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue, // Button background color is blue
            foregroundColor: Colors.white, // Button text color is white
          ),
        ),
        // Customize other dark theme aspects as needed
      ),
      themeMode: ThemeMode.system,
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