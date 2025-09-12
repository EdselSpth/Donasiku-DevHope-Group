import 'package:flutter/material.dart';

class InfoAndSupportCard extends StatelessWidget {
  // Menambahkan parameter agar versi aplikasi bisa dinamis dari luar
  final String appVersion;

  const InfoAndSupportCard({
    super.key,
    this.appVersion = '1.0.0', // Memberi nilai default jika tidak diisi
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      // Menggunakan clipBehavior untuk memastikan konten di dalamnya
      // mengikuti bentuk rounded corner dari Card.
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          ListTile(
            leading: const Icon(
              Icons.policy_outlined,
              color: Color(0xFF0D2C63),
            ),
            title: const Text('Kebijakan dan Ketentuan'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              print('Policy Tapped!');
            },
          ),
          ListTile(
            leading: const Icon(Icons.help_outline, color: Color(0xFF0D2C63)),
            title: const Text('Pusat Bantuan'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              print('Help Center Tapped!');
            },
          ),
          ListTile(
            leading: const Icon(Icons.info_outline, color: Color(0xFF0D2C63)),
            title: const Text('Versi Aplikasi'),
            trailing: Text(
              appVersion, // <-- Menggunakan variabel dari parameter
              style: const TextStyle(color: Colors.grey),
            ),
            onTap: () {}, // Biasanya item versi tidak bisa di-tap
          ),
        ],
      ),
    );
  }
}
