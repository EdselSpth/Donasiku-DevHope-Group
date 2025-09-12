import 'package:flutter/material.dart';

class FaceVerificationScreen extends StatelessWidget {
  const FaceVerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              // Logo Donasiku
              Image.asset('Assets/Logo-Donasiku.png', height: 40),
              const SizedBox(height: 50),

              // Kontainer Utama (Card)
              Card(
                elevation: 4,
                shadowColor: Colors.blue.withOpacity(0.08),
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(color: Colors.grey.shade300, width: 1),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Judul dan Subjudul
                      const Text(
                        'Verifikasi Wajah Yuk',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0D2C63),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Ambil gambar selfie anda menghadap kamera, ikuti petunjuk dibawah ya!',
                        style: TextStyle(fontSize: 13, color: Colors.black),
                      ),
                      const SizedBox(height: 24),

                      // Contoh Gambar Wajah (Benar & Salah)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildFaceExample(
                            imagePath:
                                'Assets/FotoWajahBenar.png', // Ganti dengan path aset Anda
                            label: 'Benar',
                            labelColor: Colors.green,
                          ),
                          _buildFaceExample(
                            imagePath:
                                'Assets/FotoWajahSalah.png', // Ganti dengan path aset Anda
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
                        'Foto harus diambil secara langsung, bukan dari gambar atau lainnya',
                      ),
                      _buildRuleItem(
                        '2.',
                        'Pastikan wajah menghadap tegak ke kamera dan foto tidak buram',
                      ),
                      _buildRuleItem(
                        '3.',
                        'Posisikan wajah kedalam frame supaya dapat terbaca otomatis',
                      ),
                      _buildRuleItem(
                        '4.',
                        'Carilah ruang dengan pencahayaan yang baik dan terang, kualitas gambar mempengaruhi proses verifikasi kamu ya!',
                      ),
                    ],
                  ),
                ),
              ),

              const Spacer(), // Mendorong tombol ke bawah
              // Tombol "Lanjutkan"
              ElevatedButton(
                onPressed: () {
                  // TODO: Tambahkan logika untuk membuka kamera selfie
                  print('Lanjutkan button pressed!');
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
                  'Lanjutkan',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper Widget untuk contoh Wajah (Benar/Salah)
  Widget _buildFaceExample({
    required String imagePath,
    required String label,
    required Color labelColor,
  }) {
    return Column(
      children: [
        Container(
          width: 120,
          height: 120, // Sesuaikan tinggi gambar agar lebih pas untuk wajah
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300, width: 1),
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit:
                  BoxFit.contain, // Gunakan contain agar gambar tidak terpotong
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
                color: Colors.black,
                fontSize: 13,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
