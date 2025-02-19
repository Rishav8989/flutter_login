import 'package:flutter/material.dart';
import 'package:login/login_page.dart';
import 'package:login/utils/logout_confirmation_dialog.dart';
import 'main.dart';
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
          Builder( // Wrap IconButton in Builder to get a fresh context for SnackBar
            builder: (BuildContext appBarContext) => IconButton(
              icon: const Icon(Icons.logout),
              tooltip: 'Logout',
              onPressed: () async {
                // Use LogoutConfirmationDialog to get confirmation
                bool? confirmLogout = await LogoutConfirmationDialog.show(context);

                if (confirmLogout == true) {
                  pb.authStore.clear();
                  print('Logged out from AppBar!');
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                } else if (confirmLogout == false) {
                  print('Logout cancelled from AppBar');
                  ScaffoldMessenger.of(appBarContext).showSnackBar( // Use appBarContext for SnackBar
                    const SnackBar(
                      content: Text('Logout cancelled'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                } else {
                  print('Logout dialog dismissed without choice (AppBar)');
                }
              },
            ),
          ),
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