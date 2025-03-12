// home_page.dart
import 'package:flutter/material.dart';
import 'package:login/my_drawer.dart';
import 'package:login/utils/auth/logout_button.dart';
import 'package:login/utils/theme/theme_switcher_buttons.dart';

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
          const ThemeSwitcherButtons(),
          const LogoutButton(), // LogoutButton should now be correctly imported
        ],
      ),
      drawer: const MyDrawer(),
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