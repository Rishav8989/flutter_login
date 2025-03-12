// home_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX
import 'package:login/utils/translation/locale_controller.dart';
import 'package:login/widgets/bottom_navigation.dart'; // Import HomeBottomNavigation Widget
import 'package:login/pages/account_page.dart'; // Import your page files from 'pages' folder (Correct paths!)
import 'package:login/pages/faults_page.dart';
import 'package:login/pages/monitoring_page.dart';
import 'package:login/pages/support_page.dart';
import 'package:login/widgets/home_app_bar_widget.dart'; // Import HomeAppBarWidget <--- IMPORT HERE
// import 'package:login/my_drawer.dart'; // Import MyDrawer widget (Correct path!) <--- REMOVE or COMMENT THIS LINE

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
  late LocaleController localeController; // Declare LocaleController

  @override
  void initState() {
    super.initState();
    print("HomePage initState: Checking if LocaleController is registered..."); // Debug print
    try {
      localeController = Get.find<LocaleController>();
      print("HomePage initState: LocaleController FOUND!"); // Debug print if found
    } catch (e) {
      print("HomePage initState: LocaleController NOT FOUND! Error: $e"); // Debug print if not found
      // Optionally, you could initialize with a default value in case of error (for testing):
      // localeController = LocaleController(); // This might not be ideal in production but for debugging.
      rethrow; // Re-throw the error so you still see the LateInitializationError
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBarWidget(), // Use the HomeAppBarWidget  <--- USE HERE
      // drawer: const MyDrawer(),  // <--- REMOVE or COMMENT THIS LINE (Drawer)
      body: IndexedStack( // Use IndexedStack for efficient page switching
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: HomeBottomNavigation( // HomeBottomNavigation Widget
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}