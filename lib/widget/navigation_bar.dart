import 'package:donasiku/state_management/main_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppNavigationBar extends StatelessWidget {
  const AppNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    // Find the controller that manages our state
    final MainScreenController controller = Get.find<MainScreenController>();

    // Obx widget rebuilds automatically when controller.selectedIndex changes
    return Obx(
      () => BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          // Item 1: Home
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home), // Icon when active
            label: 'Home',
          ),
          // Item 2: Donasi
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            activeIcon: Icon(Icons.favorite),
            label: 'Donasi',
          ),
          // Item 3: Riwayat
          BottomNavigationBarItem(
            icon: Icon(Icons.history_outlined),
            activeIcon: Icon(Icons.history),
            label: 'Riwayat',
          ),
          // Item 4: Profile
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex:
            controller.selectedIndex.value, // Get current index from controller
        onTap: controller.changeTabIndex, // Call controller's method on tap
        selectedItemColor: const Color(0xFF0D2C63),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
