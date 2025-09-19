import 'package:donasiku/state_management/main_screen_controller.dart';
import 'package:donasiku/user_interface/donation/donation_page.dart';
import 'package:donasiku/user_interface/navigation/homepage.dart';
import 'package:donasiku/user_interface/navigation/profile/profile_page.dart';
import 'package:donasiku/widget/navigation_bar.dart';
import 'package:donasiku/user_interface/navigation/history/history_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  MainScreen({super.key});

  final List<Widget> _pages = [
    HomePage(),
    DonationPage(),
    HistoryPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    final MainScreenController controller = Get.put(MainScreenController());

    return Scaffold(
      body: Obx(() => _pages[controller.selectedIndex.value]),
      bottomNavigationBar: const AppNavigationBar(),
    );
  }
}
