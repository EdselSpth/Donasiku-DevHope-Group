// lib/user_interface/navigation/donation_page.dart

import 'package:flutter/material.dart';
import 'package:donasiku/widget/donation_option_card.dart';
import 'package:donasiku/user_interface/navigation/donation/add_donation_page.dart';
import 'package:donasiku/user_interface/navigation/donation/item_request_page.dart'; // <-- 1. IMPORT HALAMAN BARU
import 'package:donasiku/user_interface/navigation/donation/item_request_list_page.dart';

class DonationPage extends StatelessWidget {
  const DonationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Stack(
        children: [
          // ... (Header tidak berubah)
          ClipPath(
            clipper: HeaderClipper(),
            child: Container(height: 200, color: const Color(0xFF0D2C63)),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 70),
                    const Text(
                      'Barang Donasiku',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Cari barang yang kamu inginkan',
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Kartu Opsi 1: Mulai Donasi
                    DonationOptionCard(
                      iconPath: 'Assets/gambar-donasi-barang.png',
                      title: 'Donasi Barang',
                      subtitle: 'Letakan Barang disini untuk di Donasikan',
                      buttonText: 'Mulai Donasi',
                      onButtonPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddDonationPage(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),

                    // Kartu Opsi 2: Permintaan Barang
                    DonationOptionCard(
                      iconPath: 'Assets/gambar-permintaan-barang.png',
                      title: 'Permintaan Barang',
                      subtitle:
                          'Yuk cari kebutuhan yang diperlukan oleh orang lain',
                      buttonText: 'Permintaan',
                      onButtonPressed: () {
                        // --- PERUBAHAN DI SINI ---
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ItemRequestPage(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),

                    // Kartu Opsi 3: Semua Permintaan
                    DonationOptionCard(
                      iconPath: 'Assets/gambar-permintaan-barang.png',
                      title: 'Semua Permintaan',
                      subtitle: 'Lihat semua permintaan barang yang tersedia',
                      buttonText: 'Lihat Permintaan',
                      onButtonPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ItemRequestListPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ... (Class HeaderClipper tidak berubah)
class HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 40);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - 40,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
