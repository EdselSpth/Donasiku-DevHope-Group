import 'package:donasiku/state_management/main_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppNavigationBar extends StatelessWidget {
  const AppNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final MainScreenController controller = Get.find<MainScreenController>();

    return Obx(
      () => BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          // Item 1: Home
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('Assets/ikon_donasi_navbar.png')),
            activeIcon: ImageIcon(AssetImage('Assets/ikon_donasi_navbar.png')),
            label: 'Donasi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history_outlined),
            activeIcon: Icon(Icons.history),
            label: 'Riwayat',
          ),
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
        backgroundColor: Colors.white,
      ),
    );
  }
}
