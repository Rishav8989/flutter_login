// lib/widgets/bottom_navigation.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeBottomNavigation extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const HomeBottomNavigation({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: const Icon(Icons.monitor_heart), // Choose appropriate icons
          label: 'Monitoring'.tr, // Translate Bottom Navigation labels
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.warning),
          label: 'Faults'.tr, // Translate Bottom Navigation labels
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.support_agent),
          label: 'Support'.tr, // Translate Bottom Navigation labels
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.account_circle),
          label: 'Account'.tr, // Translate Bottom Navigation labels
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Colors.blue, // Customize selected item color
      unselectedItemColor: Colors.grey, // Customize unselected item color
      onTap: onItemTapped,
      type: BottomNavigationBarType.fixed, // To show labels for all items
    );
  }
}