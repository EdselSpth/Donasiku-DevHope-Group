import 'package:flutter/material.dart';
import 'ktp_camera_screen.dart';

class UploadKtpScreen extends StatelessWidget {
  const UploadKtpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // AppBar sudah dihapus
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              // Logo Donasiku
              Image.asset('Assets/Logo-Donasiku.png', height: 40),
              const SizedBox(height: 80),

              // Kontainer Utama (Card)
              Card(
                elevation: 4,
                shadowColor: Colors.blue.withOpacity(0.08),
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(
                    color: Colors.grey.shade300,
                    width: 1,
                  ), // Border
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Judul dan Subjudul Panduan
                      const Text(
                        'Upload KTP dulu yuk!',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0D2C63),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Ambil gambar E-KTP sesuai dengan ketentuan ya! supaya data bisa kami baca otomatis.',
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                      const SizedBox(height: 24),

                      // Contoh Gambar KTP (Benar & Salah)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildKtpExample(
                            imagePath:
                                'Assets/KTP Bener.png', // Pastikan nama file benar
                            label: 'Benar',
                            labelColor: Colors.green,
                          ),
                          _buildKtpExample(
                            imagePath:
                                'Assets/KTP Salah.png', // Pastikan nama file benar
                            label: 'Salah',
                            labelColor: Colors.red,
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Bagian Perhatikan Ketentuannya
                      const Text(
                        'Perhatikan Ketentuannya ya!',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0D2C63),
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildRuleItem(
                        '1.',
                        'Foto harus diambil secara langsung ya! bukan fotokopian atau gambar',
                      ),
                      _buildRuleItem(
                        '2.',
                        'Posisikan KTP kedalam frame supaya data dapat terbaca otomatis dan benar',
                      ),
                      _buildRuleItem(
                        '3.',
                        'Carilah tempat dengan pencahayaan yang bagus ya, usahakan data terlihat jelas dan tidak buram',
                      ),
                    ],
                  ),
                ),
              ),

              const Spacer(), // Mendorong tombol ke bawah
              // Tombol "Ambil Foto"
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const KtpCameraScreen(cameraMode: CameraMode.ktp),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: const Color(0xFF0D2C63),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                child: const Text(
                  'Ambil Foto',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper Widget untuk contoh KTP (Benar/Salah)
  Widget _buildKtpExample({
    required String imagePath,
    required String label,
    required Color labelColor,
  }) {
    return Column(
      children: [
        Container(
          width: 120, // Sesuaikan lebar gambar
          height: 80, // Sesuaikan tinggi gambar
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300, width: 1),
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover, // Sesuaikan fit agar gambar pas
            ),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: labelColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  // Helper Widget untuk setiap poin ketentuan
  Widget _buildRuleItem(String number, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            number,
            style: const TextStyle(
              color: Color(0xFF0D2C63),
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 13,
                height: 1.4, // Untuk jarak antar baris
              ),
            ),
          ),
        ],
      ),
    );
  }
}
