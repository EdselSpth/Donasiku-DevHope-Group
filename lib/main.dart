import 'package:donasiku/user-interface/onboarding/onboardingScreen.dart';
import 'package:donasiku/user-interface/splashScreen/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:donasiku/state-management/roleController.dart';

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
