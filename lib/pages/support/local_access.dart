import 'package:flutter/material.dart';

class LocalAccess extends StatefulWidget {
  const LocalAccess({super.key});

  @override
  State<LocalAccess> createState() => _LocalAccessState();
}

class _LocalAccessState extends State<LocalAccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'), // You can customize the AppBar title
        centerTitle: true, // Center the title in the AppBar
      ),
      body: Center( // Center the content on the screen
        child: Padding(
          padding: const EdgeInsets.all(20.0), // Add some padding around the text
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center vertically
            children: <Widget>[
              const Text(
                'Welcome to Local Access!', // Your welcome message
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center, // Center the text horizontally
              ),
              const SizedBox(height: 20.0), // Add some space below the welcome text
              Text(
                'This is your Local Access page. You can customize this page to display relevant information or actions for local access.',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey[600], // Slightly muted color for description
                ),
                textAlign: TextAlign.center, // Center the description text
              ),
              // You can add more widgets here, like buttons, images, etc.
            ],
          ),
        ),
      ),
    );
  }
}