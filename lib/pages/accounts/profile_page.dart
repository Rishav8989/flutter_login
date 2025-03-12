// lib/pages/profile_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX for theming if needed

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String nickname = ''; // State for Nickname input
  String username = 'Rishav'; // Hardcoded Username as per image
  String countryRegion = 'India'; // Hardcoded Country/Region as per image
  String email = 'temp@gmail.com'; // Hardcoded Email as per image
  String timeZone = 'GMT+5.5 Chennai, Kolkata, Mumbai'; // Hardcoded Time Zone as per image

  @override
  Widget build(BuildContext context) {
    // Define a max width for desktop/larger screens - Same as AccountPage
    final double maxWidth = 600.0; // Adjust this value as needed
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > maxWidth;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold), // **AppBar Title Bold**
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              // Implement Confirm action here
              print('Confirm button pressed');
            },
            child: const Text(
              'Confirm',
              style: TextStyle(
                color: Colors.white, // Keep white for visibility on AppBar's primary color
                fontWeight: FontWeight.bold, // **Confirm Text Bold**
              ),
            ),
          ),
        ],
      ),
      body: Center( // Wrap with Center to keep content centered on larger screens
        child: ConstrainedBox( // Apply maxWidth constraint
          constraints: BoxConstraints(
            maxWidth: isDesktop ? maxWidth : double.infinity, // Apply maxWidth only on desktop
          ),
          child: Padding( // Add padding for the content within the maxWidth
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: <Widget>[
                // Avatar Section
Center(
  child: Stack(
    alignment: Alignment.bottomRight,
    children: <Widget>[
      CircleAvatar(
        radius: 50,
        backgroundImage: const NetworkImage('https://rishavwiki.netlify.app/assets/1707189968207-01.jpeg'), // **Use NetworkImage for your photo URL**
        backgroundColor: Theme.of(context).colorScheme.surfaceVariant, // Theme aware surface variant color for Avatar background (fallback if image fails to load or is transparent)
        onBackgroundImageError: (exception, stackTrace) { // Optional error handling
          print('Error loading image: $exception');
          // You can optionally show a placeholder icon or color here if the image fails to load.
        },
      ),
    ],
  ),
),
                const SizedBox(height: 8),
                Center(child: Text('Avatar', style: TextStyle(color: Theme.of(context).disabledColor, fontWeight: FontWeight.w600))), // **Avatar Text Bolder**
                const SizedBox(height: 24),

                // Nickname Input
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Nickname',
                    labelStyle: const TextStyle(fontWeight: FontWeight.w600), // **Nickname Label Bolder**
                    hintText: 'Please Enter',
                    border: OutlineInputBorder( // Added OutlineInputBorder for border
                      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                      borderSide: BorderSide(width: 1.0, color: Colors.grey.shade400), // Added border width and color
                    ),
                    enabledBorder: OutlineInputBorder( // Styling when the field is enabled but not focused
                      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                      borderSide: BorderSide(width: 1.0, color: Colors.grey.shade400),
                    ),
                    focusedBorder: OutlineInputBorder( // Styling when the field is focused
                      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                      borderSide: BorderSide(width: 2.0, color: Theme.of(context).primaryColor), // Example: Use primary color when focused
                    ),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surfaceVariant, // Theme aware surface variant color for input background
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0), // Increased vertical padding
                  ),
                  onChanged: (value) {
                    setState(() {
                      nickname = value;
                    });
                  },
                ),
                const SizedBox(height: 20),

                // Username Display
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceVariant, // Theme aware surface variant color for container background
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    border: Border.all(width: 1.0, color: Colors.grey.shade400), // Added border to Container
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0), // Increased vertical padding
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Username',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold, // **Username Label Bold**
                          color: Theme.of(context).textTheme.bodyMedium?.color, // Theme aware text color for label
                        ),
                      ),
                      const SizedBox(height: 6), // Increased spacing
                      Text(
                        username,
                        style: TextStyle(
                          fontSize: 18, // Increased font size for value
                          color: Theme.of(context).textTheme.bodyMedium?.color, // Theme aware text color for value
                          fontWeight: FontWeight.w600, // **Username Value Bolder**
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Country/Region ListTile
                Card( // Using Card to mimic the rounded background and spacing
                  elevation: 0, // No shadow
                  color: Theme.of(context).colorScheme.surfaceVariant, // Theme aware surface variant color for Card background
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide(width: 1.0, color: Colors.grey.shade400) // Added border to Card
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0), // Adjusted vertical padding
                    title: Text(
                      'Country/Region',
                      style: TextStyle(fontSize: 16, color: Theme.of(context).textTheme.bodyMedium?.color, fontWeight: FontWeight.bold), // **Country/Region Title Bold**
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          countryRegion,
                          style: TextStyle(fontSize: 16, color: Theme.of(context).disabledColor, fontWeight: FontWeight.w500), // **Country/Region Value Bolder**
                        ),
                        const Icon(Icons.chevron_right, color: Colors.grey),
                      ],
                    ),
                    onTap: () {
                      // Implement Country/Region selection here
                      print('Country/Region tapped');
                    },
                  ),
                ),
                const SizedBox(height: 10),

                // Email ListTile
                Card(
                  elevation: 0,
                  color: Theme.of(context).colorScheme.surfaceVariant, // Theme aware surface variant color for Card background
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide(width: 1.0, color: Colors.grey.shade400) // Added border to Card
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0), // Adjusted vertical padding
                    title: Text(
                      'Email',
                      style: TextStyle(fontSize: 16, color: Theme.of(context).textTheme.bodyMedium?.color, fontWeight: FontWeight.bold), // **Email Title Bold**
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          email,
                          style: TextStyle(fontSize: 16, color: Theme.of(context).disabledColor, fontWeight: FontWeight.w500), // **Email Value Bolder**
                        ),
                        const Icon(Icons.chevron_right, color: Colors.grey),
                      ],
                    ),
                    onTap: () {
                      // Implement Email change here
                      print('Email tapped');
                    },
                  ),
                ),
                const SizedBox(height: 10),

                // Time Zone ListTile
                Card(
                  elevation: 0,
                  color: Theme.of(context).colorScheme.surfaceVariant, // Theme aware surface variant color for Card background
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide(width: 1.0, color: Colors.grey.shade400) // Added border to Card
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0), // Adjusted vertical padding
                    title: Text(
                      'Time Zone',
                      style: TextStyle(fontSize: 16, color: Theme.of(context).textTheme.bodyMedium?.color, fontWeight: FontWeight.bold), // **Time Zone Title Bold**
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Flexible( // Use Flexible to handle long text and prevent overflow
                          child: Text(
                            timeZone,
                            style: TextStyle(fontSize: 16, color: Theme.of(context).disabledColor, fontWeight: FontWeight.w500), // **Time Zone Value Bolder**
                            overflow: TextOverflow.ellipsis, // Ellipsis for overflow
                          ),
                        ),
                        const Icon(Icons.chevron_right, color: Colors.grey),
                      ],
                    ),
                    onTap: () {
                      // Implement Time Zone selection here
                      print('Time Zone tapped');
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}