import 'package:donasiku/user_interface/auth/login_screen.dart';
import 'package:donasiku/widget/account_setting_card.dart';
import 'package:donasiku/widget/info_and_support_card.dart';
import 'package:donasiku/widget/logout_button.dart';
import 'package:donasiku/widget/profile_header.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 45),
            ProfileHeader(),
            const SizedBox(height: 24),
            AccountSettingsCard(),
            const SizedBox(height: 24),
            InfoAndSupportCard(),
            const SizedBox(height: 32),
            LogoutButton(
              onPressed: () {
                // Aksi logout
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
