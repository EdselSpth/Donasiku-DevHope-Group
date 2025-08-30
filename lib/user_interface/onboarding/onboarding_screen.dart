import 'package:donasiku/user_interface/onboarding/policy_page.dart';
import 'package:flutter/material.dart';
import 'package:donasiku/user_interface/onboarding/onboarding_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      children: [
        OnboardingPage(
          imagePath: "Assets/onboarding1.png",
          title: "Donasi Menjadi Mudah",
          description:
              "Donasiku adalah platform untuk memberikan donasi barang layak pakai ke berbagai kalangan, ini merupakan program sosial untuk membantu sesama manusia.",
          buttonText: "Lanjut",
          onPressed: () {
            _pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
        ),
        OnboardingPage(
          imagePath: "Assets/onboarding2.png",
          title: "Punya barang bekas layak pakai?",
          description:
              "Jangan biarkan barang tak terpakai menumpuk. Donasikan dengan mudah lewat Donasiku dan bantu mereka yang membutuhkan",
          buttonText: "Lanjut",
          onPressed: () {
            _pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
        ),
        OnboardingPage(
          imagePath: "Assets/onboarding3.png",
          title: "Maknai setiap hidup sebagai donatur",
          description:
              "Setiap donasi membawa harapan baru, jadilah bagian dari perubahan dan kebahagiaan bagi sesama.",
          buttonText: "Mulai Donasi",
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PrivacyPolicyScreen(),
              ),
            );
          },
        ),
      ],
    );
  }
}
