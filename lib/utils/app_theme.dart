import 'package:flutter/material.dart';

ThemeData amoled = ThemeData.dark().copyWith(
  scaffoldBackgroundColor: Colors.black, // **AMOLED: Set Scaffold background to true black**
  primaryColor: Colors.blue, // Keep blue accent color
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black, // **AMOLED: Set AppBar background to true black**
    titleTextStyle: TextStyle(
      color: Colors.white, // Keep white title text
    ),
  ),
  drawerTheme: const DrawerThemeData(
    backgroundColor: Colors.black, // **AMOLED: Set Drawer background to true black**
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: Colors.white), // Keep white text color
    // You can customize other text styles here for dark theme
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.blue, // Keep blue FAB background
    foregroundColor: Colors.white, // Keep white FAB icon color
  ),
  iconTheme: const IconThemeData(color: Colors.white), // Keep white icons
  elevatedButtonTheme: ElevatedButtonThemeData(
    // Style for ElevatedButton in dark theme
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blue, // Keep blue button background
      foregroundColor: Colors.white, // Keep white button text color
    ),
  ),
  // Customize other dark theme aspects as needed
);


ThemeData lightTheme = ThemeData(
  primarySwatch: Colors.blue, // Primary color is blue for light theme
  primaryColor: Colors.blue, // Ensure primaryColor is blue
  scaffoldBackgroundColor: Colors.white, // **Light Theme: Set Scaffold background to white**
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white, // **Light Theme: Set AppBar background to white**
    foregroundColor: Colors.blue, // **Light Theme: Set AppBar text/icon color to blue**
    titleTextStyle: TextStyle(
      color: Colors.blue, // **Light Theme: Set AppBar title text color to blue**
    ),
    iconTheme: IconThemeData(color: Colors.blue), // **Light Theme: Set AppBar icons to blue**
  ),
  drawerTheme: const DrawerThemeData(
    backgroundColor: Colors.white, // **Light Theme: Set Drawer background to white**
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: Colors.black87), // Keep default dark grey text color for light theme
    // You can customize other text styles here for light theme
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    // Style for ElevatedButton in light theme
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blue, // Button background color is blue
      foregroundColor: Colors.white, // Button text color is white
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.blue, // FAB background is blue
    foregroundColor: Colors.white, // FAB icon color is white
  ),
  iconTheme: const IconThemeData(color: Color.fromARGB(255, 56, 73, 82)), // **Light Theme: Set general icons to dark grey/blueGrey**
  // You can customize other parts of the light theme if needed
  colorScheme: ColorScheme.light( // Define a light color scheme for better consistency
    primary: Colors.blue,
    secondary: Colors.blueAccent, // Example secondary color
    background: Colors.white,
    surface: Colors.white,
    onBackground: Colors.black87,
    onSurface: Colors.black87,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
  ),
);



ThemeData darkTheme = ThemeData.dark().copyWith(
  scaffoldBackgroundColor: const Color.fromARGB(255, 32, 32, 32), // **Gentle Dark: Dark Grey Scaffold background**
  primaryColor: Colors.blue, // Keep blue accent color
  appBarTheme: AppBarTheme(
    backgroundColor: const Color.fromARGB(255, 26, 26, 26), // **Gentle Dark: Dark Grey AppBar background**
    titleTextStyle: const TextStyle(
      color: Colors.white, // Keep white title text
    ),
    iconTheme: const IconThemeData(color: Colors.white), // Keep white icons
  ),
  drawerTheme: DrawerThemeData(
    backgroundColor: const Color.fromARGB(255, 48, 48, 48), // **Gentle Dark: Dark Grey Drawer background**
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: Colors.white), // Keep white text color
    // Customize other text styles here for dark theme
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.blue, // Keep blue FAB background
    foregroundColor: Colors.white, // Keep white FAB icon color
  ),
  iconTheme: const IconThemeData(color: Colors.white), // Keep white icons
  elevatedButtonTheme: ElevatedButtonThemeData(
    // Style for ElevatedButton in dark theme
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blue, // Keep blue button background
      foregroundColor: Colors.white, // Keep white button text color
    ),
  ),
  // Customize other dark theme aspects as needed
  colorScheme: ColorScheme.dark().copyWith( // Keep ColorScheme.dark and update surface/background
    surface: Colors.grey[850],      // **Gentle Dark: Dark Grey Surface color (Cards, etc.)**
    background: Colors.grey[850],   // **Gentle Dark: Dark Grey Background color**
  ),
);