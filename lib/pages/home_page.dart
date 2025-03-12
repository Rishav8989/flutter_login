// home_page.dart
import 'package:flutter/material.dart';

import 'package:login/pages/account_page.dart'; // Import your page files from 'pages' folder
import 'package:login/pages/faults_page.dart';
import 'package:login/pages/monitoring_page.dart';
import 'package:login/pages/support_page.dart';
import 'package:login/utils/theme/theme_switcher_buttons.dart';
import 'package:login/utils/auth/logout_button.dart'; // Import LogoutButton widget (corrected path)
import 'package:login/my_drawer.dart'; // Import MyDrawer widget

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // To keep track of the current selected tab
  final List<Widget> _pages = const [ // List of pages for bottom navigation
    MonitoringPage(),
    FaultsPage(),
    SupportPage(),
    AccountPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Solar Square', // Static App Name in AppBar
        ),
        centerTitle: true,
        actions: <Widget>[
          const ThemeSwitcherButtons(), // Theme Switcher Buttons in AppBar
          const LogoutButton(),         // Logout Button in AppBar
        ],
        leading: Builder( // Add Drawer icon in the leading slot
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),
      drawer: const MyDrawer(), // Add Drawer to the Scaffold
      body: IndexedStack( // Use IndexedStack for efficient page switching
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.monitor_heart), // Choose appropriate icons
            label: 'Monitoring',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.warning),
            label: 'Faults',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.support_agent),
            label: 'Support',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue, // Customize selected item color
        unselectedItemColor: Colors.grey, // Customize unselected item color
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed, // To show labels for all items
      ),
    );
  }
}