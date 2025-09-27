import 'package:donasiku/services/user/user_api_service.dart';
import 'package:donasiku/user_interface/auth/login_screen.dart';
import 'package:donasiku/widget/account_setting_card.dart';
import 'package:donasiku/widget/info_and_support_card.dart';
import 'package:donasiku/widget/logout_button.dart';
import 'package:donasiku/widget/profile_header.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final UserService userService = UserService();
  Map<String, dynamic>? _user;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getUserProfile();
  }

  Future<void> _getUserProfile() async {
    try {
      final user = await userService.getProfile();
      setState(() {
        _user = user['user'];
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 45),
            if (_isLoading)
              const Center(child: CircularProgressIndicator())
            else if (_user != null)
              ProfileHeader(user: _user!),
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