import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:donasiku/user_interface/Verification/upload_ktp_screen.dart';

class VerificationGuideScreen extends StatelessWidget {
  const VerificationGuideScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Warna background biru muda
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              // 1. Logo Donasiku
              Image.asset(
                'Assets/Logo-Donasiku.png', // Pastikan path ini sesuai
                height: 40,
              ),
              const SizedBox(height: 40),

              // 2. Judul dan Subjudul
              const Text(
                'Panduan Verifikasi dan Login',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D2C63),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Silahkan lakukan pendaftaran akun dengan mengikuti langkah-langkah dibawah ini ya!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 32),

              // 3. Kontainer Putih berisi Langkah-langkah
              Container(
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(
                    // <-- TAMBAHKAN BARIS INI
                    color: Colors.grey.shade300, // Warna border
                    width: 1.5, // Ketebalan border
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.05),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildStepItem(
                      number: '1',
                      title: 'Siapkan Dokumen',
                      subtitle: 'Siapkan E-KTP ya!',
                    ),
                    _buildStepItem(
                      number: '2',
                      title: 'Pengisian Data',
                      subtitle:
                          'Nanti kamu bakalan isi formulir pendaftaran, pastikan semua data valid ya!',
                    ),
                    _buildStepItem(
                      number: '3',
                      title: 'Verifikasi Data',
                      subtitle:
                          'Nanti kami akan verifikasi data yang kamu kirim, tenang data kamu 100% aman kok.',
                    ),
                    _buildStepItem(
                      number: '4',
                      title: 'Buat Akun Donasiku',
                      subtitle: 'Buat Username dan Password',
                      isLast: true, // Tandai sebagai item terakhir
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 4. Teks Informasi Keamanan
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontFamily: 'Poppins', // Sesuaikan jika font beda
                    ),
                    children: [
                      const TextSpan(
                        text:
                            'Semua proses dilakukan dalam aplikasi Donasiku, seluruh data pengguna aman dan dilindungi enkripsi end-to-end! ',
                      ),
                      TextSpan(
                        text: 'Pelajari Selengkapnya',
                        style: const TextStyle(
                          color: Color(0xFF0D2C63),
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer:
                            TapGestureRecognizer()
                              ..onTap = () {
                                // TODO: Tambahkan aksi saat "Pelajari Selengkapnya" di-tap
                                print('Learn More Tapped!');
                              },
                      ),
                    ],
                  ),
                ),
              ),

              const Spacer(), // Mendorong tombol ke bawah
              // 5. Tombol Aksi
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        // TODO: Tambahkan aksi untuk "Pilih nanti"
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        foregroundColor: const Color(0xFF0D2C63),
                        side: const BorderSide(
                          color: Color(0xFF0D2C63),
                          width: 1.5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Pilih nanti',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const UploadKtpScreen(),
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
                      ),
                      child: const Text(
                        'Verifikasi',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget untuk membuat setiap item langkah
  Widget _buildStepItem({
    required String number,
    required String title,
    required String subtitle,
    bool isLast = false,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Center(
                  child: Text(
                    number,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // Tampilkan garis hanya jika bukan item terakhir
              if (!isLast)
                Expanded(
                  child: Container(width: 1.5, color: Colors.grey.shade300),
                ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              // Padding bawah agar ada jarak dengan item berikutnya
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
