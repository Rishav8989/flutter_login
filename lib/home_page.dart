// home_page.dart
import 'package:flutter/material.dart';
import 'package:login/utils/logout_button.dart';
import 'my_drawer.dart'; // Import the MyDrawer widget

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notes',
        ),
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Colors.blue,
          fontSize: 20,
        ),
        actions: <Widget>[
          const LogoutButton(), // Use the separate LogoutButton widget
        ],
      ),
      drawer: const MyDrawer(), // Add the drawer property and use MyDrawer widget
      body: const Center(
        child: Text('Welcome to the Notes App!'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('Floating action button pressed to add note');
        },
        tooltip: 'Add Note',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}