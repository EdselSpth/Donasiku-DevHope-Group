import 'package:donasiku/state_management/main_screen_controller.dart';
import 'package:donasiku/user_interface/navigation/homepage.dart';
import 'package:donasiku/widget/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Placeholder for other screens
class PlaceholderWidget extends StatelessWidget {
  final String title;
  const PlaceholderWidget(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text(title, style: const TextStyle(fontSize: 24))),
    );
  }
}

class MainScreen extends StatelessWidget {
  // Note: I also removed 'const' from the constructor
  MainScreen({super.key});

  // ✅ Solution: Remove 'const' from the list initialization.
  final List<Widget> _pages = [
    HomePage(), // Your actual homepage
    const PlaceholderWidget('Donasi'), // Replace with your Donasi screen
    const PlaceholderWidget('Riwayat'), // Replace with your Riwayat screen
    const PlaceholderWidget('Profile'), // Replace with your Profile screen
  ];

  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    final MainScreenController controller = Get.put(MainScreenController());

    return Scaffold(
      // The body will change based on the selected index from the controller
      body: Obx(() => _pages[controller.selectedIndex.value]),
      // Add our reusable navigation bar widget here
      bottomNavigationBar: const AppNavigationBar(),
    );
  }
}
