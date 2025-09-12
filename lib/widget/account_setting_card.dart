import 'package:flutter/material.dart';
import 'package:donasiku/user_interface/Verification/verification_guide_screen.dart';

class AccountSettingsCard extends StatelessWidget {
  const AccountSettingsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pengaturan Akun',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ListTile(
              // Menambahkan sedikit padding konten agar tidak terlalu mepet
              contentPadding: EdgeInsets.zero,
              leading: const Icon(
                Icons.verified_user_outlined,
                color: Color(0xFF0D2C63),
              ),
              title: const Text('Verifikasi Akun Sekarang'),
              subtitle: const Text('Akun sudah terverifikasi'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const VerificationGuideScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
