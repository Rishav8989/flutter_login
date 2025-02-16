import 'package:flutter/material.dart';
import 'package:login/login_page.dart'; // Import LoginPage
import 'main.dart'; // Import global pb instance

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Welcome to the Home Page!'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement Logout functionality
                pb.authStore.clear(); // Clear the auth store
                print('Logged out!');
                // Correct Navigation: Use pushReplacement with MaterialPageRoute to LoginPage
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              child: const Text('Logout'), // Changed button text to just "Logout"
            ),
          ],
        ),
      ),
    );
  }
}