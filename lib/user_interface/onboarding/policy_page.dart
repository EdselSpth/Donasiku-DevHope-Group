import 'package:flutter/material.dart';
import 'package:donasiku/user_interface/auth/register_screen.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Warna latar belakang abu-abu muda
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo di atas Card
              Image.asset(
                'Assets/Logo-Donasiku.png', // Pastikan path logo benar
                height: 40,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 24),

              // Card untuk Kebijakan Privasi
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                elevation: 4, // Efek bayangan
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16), // Sudut membulat
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize:
                        MainAxisSize.min, // Agar card menyesuaikan konten
                    children: [
                      const Center(
                        child: Text(
                          "Kebijakan Privasi & Syarat Penggunaan Aplikasi Donasiku",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        "Dengan menggunakan aplikasi Donasiku, Anda setuju dengan hal berikut:",
                        style: TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 16),

                      _buildPolicyPoint(
                        '1. Data Pengguna',
                        'Kami menyimpan data akun, data donasi, serta data penerima hanya untuk keperluan verifikasi dan proses donasi.',
                      ),
                      _buildPolicyPoint(
                        '2. Kerahasiaan',
                        'Data tidak akan dijual/disewakan, hanya digunakan untuk menghubungkan donatur dan penerima.',
                      ),
                      _buildPolicyPoint(
                        '3. Hak & Kewajiban',
                        '• Donatur wajib mendonasikan barang layak pakai.\n• Penerima wajib menggunakan barang sesuai kebutuhan sosial, bukan untuk komersial.\n• Pengguna bertanggung jawab menjaga akun masing-masing.',
                      ),
                      _buildPolicyPoint(
                        '4. Konten & Barang Donasi',
                        'Donasiku tidak bertanggung jawab atas kualitas/kondisi barang, namun kami melakukan verifikasi dasar.',
                      ),
                      _buildPolicyPoint(
                        '5. Pembatasan Tanggung Jawab',
                        'Donasiku adalah platform penghubung, bukan pihak pengirim.',
                      ),
                      _buildPolicyPoint(
                        '6. Perubahan Kebijakan',
                        'Syarat & privasi dapat diperbarui sewaktu-waktu.',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(
                        0xFF0D2C63,
                      ), // Warna biru navy
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Saya Setuju & Lanjutkan",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget helper untuk membuat setiap poin kebijakan
  Widget _buildPolicyPoint(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: '$title – ',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            TextSpan(text: content, style: const TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
