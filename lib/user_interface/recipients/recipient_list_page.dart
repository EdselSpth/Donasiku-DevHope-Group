// lib/user_interface/recipients/recipient_list_page.dart

import 'package:donasiku/models/recipient_model.dart';
import 'package:flutter/material.dart';
import 'package:donasiku/user_interface/recipients/recipient_category_list_page.dart';
import 'package:donasiku/widget/category_card.dart';

class RecipientListPage extends StatelessWidget {
  RecipientListPage({super.key});

  // --- PERBAIKAN DI SINI: HAPUS 'const' ---
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

  // --- PERBAIKAN DI SINI: HAPUS 'const' ---
  final List<RecipientModel> pantiAsuhanList = [
    RecipientModel(
      logoUrl: 'Assets/nurul_ihsan.png',
      name: 'Nurul Ihsan Bandung',
      description:
          'Komunitas yang bergerak dalam bidang sosial dan tersebar seluruh bandung.',
    ),
    RecipientModel(
      logoUrl: 'Assets/al_amin.png', // Saya ganti placeholder agar beda
      name: 'Al - Amin Bandung',
      description:
          'Komunitas yang bergerak dalam bidang sosial dan tersebar seluruh bandung.',
    ),
    RecipientModel(
      logoUrl: 'Assets/al_hafidz.png', // Saya ganti placeholder agar beda
      name: 'Al - Hafidz Bandung',
      description:
          'Komunitas yang bergerak dalam bidang sosial dan tersebar seluruh bandung.',
    ),
  ];

  // --- PERBAIKAN DI SINI: HAPUS 'const' ---
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
    // ... (sisa kode tidak perlu diubah)
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Penerima Aplikasi Donasiku')),
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 2,
              color: Colors.blue.shade50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.blue.shade200),
              ),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.blue),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Informasi Donasi',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Donasiku mendukung penyaluran donasi ke Komunitas, Panti Asuhan, Panti Jompo.',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Jelajahi',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            CategoryCard(
              icon: Icons.people_outline,
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
              icon: Icons.home_work_outlined,
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
              icon: Icons.elderly_outlined,
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
    );
  }
}
