import 'package:flutter/material.dart';
import 'package:login/login_page.dart'; // Import LoginPage
import 'main.dart'; // Import global pb instance

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notes',
        ),
        centerTitle: true, // Center the title
        titleTextStyle: const TextStyle(
          color: Colors.blue, // Blue color for the title
          fontSize: 20, // Optional: Adjust font size if needed
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout), // Logout icon
            tooltip: 'Logout',
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
          ),
        ],
      ),
      body: const Center(
        child: Text('Welcome to the Notes App!'), // Simple welcome message in the body
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Action to add notes when FAB is pressed
          print('Floating action button pressed to add note');
          // You can navigate to a new page or show a dialog to add notes here
        },
        tooltip: 'Add Note',
        child: const Icon(Icons.add), // Add icon for FAB
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat, // Default position is bottom right
    );
  }
}