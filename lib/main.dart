import 'package:donasiku/user_interface/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:donasiku/state_management/role_controller.dart';

void main() {
  Get.put(RoleController());
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnboardingScreen(),
    );
  }
}
