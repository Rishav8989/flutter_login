import 'package:flutter/material.dart';


ThemeData lightTheme = ThemeData(
  // **Light Theme - White and Blue**
  primarySwatch: Colors.blue,
  primaryColor: Colors.blue,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    foregroundColor: Colors.blue,
    titleTextStyle: TextStyle(
      color: Colors.blue,
    ),
    iconTheme: IconThemeData(color: Colors.blue),
  ),
  drawerTheme: const DrawerThemeData(
    backgroundColor: Colors.white,
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: Colors.black87),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.blue,
    foregroundColor: Colors.white,
  ),
  iconTheme: const IconThemeData(color: Color.fromARGB(255, 56, 73, 82)),
  colorScheme: ColorScheme.light(
    primary: Colors.blue,
    secondary: Colors.blueAccent,
    surface: Colors.white,
    onSurfaceVariant: Colors.black87,
    onSurface: Colors.black87,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
  ),
);


ThemeData darkTheme = ThemeData.dark().copyWith(
  // **Dark Theme - Dark Grey**
  scaffoldBackgroundColor: const Color.fromARGB(255, 32, 32, 32), // Dark Grey
  primaryColor: Colors.blue,
  appBarTheme: AppBarTheme(
    backgroundColor: const Color.fromARGB(255, 26, 26, 26), // Slightly darker Grey AppBar
    titleTextStyle: const TextStyle(
      color: Colors.white70, // Less bright white for dark grey background
    ),
    iconTheme: const IconThemeData(color: Colors.white70), // Less bright white icons
  ),
  drawerTheme: DrawerThemeData(
    backgroundColor: const Color.fromARGB(255, 48, 48, 48), // Medium Dark Grey Drawer
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: Colors.white70), // Less bright white text
    // Customize other text styles here for dark theme
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.blue,
    foregroundColor: Colors.white,
  ),
  iconTheme: const IconThemeData(color: Colors.white70), // Less bright white icons
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
    ),
  ),
  colorScheme: ColorScheme.dark().copyWith(
    surface: Colors.grey[850],      // Dark Grey Surface
    background: Colors.grey[850],   // Dark Grey Background
  ),
);