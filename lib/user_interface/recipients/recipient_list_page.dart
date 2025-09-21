// lib/user_interface/recipients/recipient_list_page.dart

import 'package:donasiku/models/recipient_model.dart';
import 'package:flutter/material.dart';
import 'package:donasiku/user_interface/recipients/recipient_category_list_page.dart';
import 'package:donasiku/widget/category_card.dart';

class RecipientListPage extends StatelessWidget {
  RecipientListPage({super.key});

  final List<RecipientModel> komunitasList = [
    RecipientModel(
      logoUrl: 'Assets/wikimedia.png',
      name: 'Komunitas Wikimedia Bandung',
      description:
          'Komunitas yang bergerak dalam bidang sosial dan tersebar seluruh bandung.',
    ),
    RecipientModel(
      logoUrl: 'Assets/dinsos_logo.png',
      name: 'Dinas Sosial Bandung',
      description:
          'Komunitas yang bergerak dalam bidang sosial dan tersebar seluruh bandung.',
    ),
    RecipientModel(
      logoUrl: 'Assets/bandung_care.png',
      name: 'Bandung Care',
      description:
          'Komunitas yang bergerak dalam bidang sosial dan tersebar seluruh bandung.',
    ),
    RecipientModel(
      logoUrl: 'Assets/indo_volunteer.png',
      name: 'Indo Volunteer Bandung',
      description:
          'Komunitas yang bergerak dalam bidang sosial dan tersebar seluruh bandung.',
      isVerified: false,
    ),
  ];

  final List<RecipientModel> pantiAsuhanList = [
    RecipientModel(
      logoUrl: 'Assets/nurul_ihsan.png',
      name: 'Nurul Ihsan Bandung',
      description:
          'Komunitas yang bergerak dalam bidang sosial dan tersebar seluruh bandung.',
    ),
    RecipientModel(
      logoUrl: 'Assets/al_amin.png',
      name: 'Al - Amin Bandung',
      description:
          'Komunitas yang bergerak dalam bidang sosial dan tersebar seluruh bandung.',
    ),
    RecipientModel(
      logoUrl: 'Assets/al_hafidz.png',
      name: 'Al - Hafidz Bandung',
      description:
          'Komunitas yang bergerak dalam bidang sosial dan tersebar seluruh bandung.',
    ),
  ];

  final List<RecipientModel> pantiJompoList = [
    RecipientModel(
      logoUrl: 'Assets/samiyah_amal.png',
      name: 'Samiyah Amal Insani Bandung',
      description:
          'Komunitas yang bergerak dalam bidang sosial dan tersebar seluruh bandung.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      backgroundColor: Colors.grey[100],
      body: Stack(
        children: [
          // Latar belakang biru melengkung
          ClipPath(
            clipper: HeaderClipper(),
            child: Container(
              // PENYESUAIAN 1: Tinggi header diperbesar
              height: 220,
              color: const Color(0xFF0D2C63),
            ),
          ),
          // Konten halaman
          SafeArea(
            child: Column(
              children: [
                // AppBar Kustom
                _buildCustomAppBar(context),
                // Konten yang bisa di-scroll
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        _buildInfoCard(),
                        const SizedBox(height: 24),
                        const Text(
                          'Jelajahi',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        CategoryCard(
                          iconPath: 'Assets/komunitas.png',
                          title: 'Komunitas',
                          subtitle:
                              'Komunitas yang bergerak dalam bidang sosial dan tersebar seluruh bandung.',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => RecipientCategoryListPage(
                                      title: 'Daftar Komunitas',
                                      recipients: komunitasList,
                                    ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 12),
                        CategoryCard(
                          iconPath: 'Assets/panti-asuhan.png',
                          title: 'Panti Asuhan',
                          subtitle:
                              'Komunitas yang bergerak dalam bidang sosial dan tersebar seluruh bandung.',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => RecipientCategoryListPage(
                                      title: 'Daftar Panti Asuhan',
                                      recipients: pantiAsuhanList,
                                    ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 12),
                        CategoryCard(
                          iconPath: 'Assets/panti-jompo.png',
                          title: 'Panti Jompo',
                          subtitle:
                              'Komunitas yang bergerak dalam bidang sosial dan tersebar seluruh bandung.',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => RecipientCategoryListPage(
                                      title: 'Daftar Panti Jompo',
                                      recipients: pantiJompoList,
                                    ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          const Expanded(
            child: Text(
              'Daftar Penerima Aplikasi Donasiku',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _buildInfoCard() {
    return Card(
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(Icons.lightbulb_outline, color: Colors.yellow.shade700),
            const SizedBox(width: 16),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Informasi Donasi',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Donasiku mendukung penyaluran donasi ke: Komunitas, Panti Asuhan, Panti Jompo.',
                    style: TextStyle(fontSize: 13),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 50);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - 50,
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
