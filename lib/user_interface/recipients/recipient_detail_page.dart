// lib/user_interface/recipients/recipient_detail_page.dart

import 'package:donasiku/models/recipient_model.dart';
import 'package:flutter/material.dart';

class RecipientDetailPage extends StatelessWidget {
  final RecipientModel recipient;

  const RecipientDetailPage({super.key, required this.recipient});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Stack(
        children: [
          // Background Biru
          Container(
            height: 200,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF0D2C63),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
            ),
          ),
          // Konten
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // App Bar Transparan
                  AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    leading: const BackButton(color: Colors.white),
                    title: const Text(
                      'Detail Komunitas',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),

                  // Kartu Informasi Utama
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: _buildInfoCard(),
                  ),
                  const SizedBox(height: 24),

                  // Bagian Informasi Lainnya
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: _buildOtherInfo(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard() {
    return Card(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: AssetImage(recipient.logoUrl),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        recipient.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        recipient.description,
                        style: TextStyle(color: Colors.grey[600], fontSize: 13),
                      ),
                    ],
                  ),
                ),
                if (recipient.isVerified)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.check_circle, color: Colors.blue, size: 12),
                        SizedBox(width: 4),
                        Text(
                          'Terverifikasi',
                          style: TextStyle(color: Colors.blue, fontSize: 11),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              recipient.fullDescription ?? recipient.description,
              style: TextStyle(color: Colors.grey[800], fontSize: 14),
            ),
            const SizedBox(height: 16),

            // 2. Tombol dan alamat tidak perlu diubah, karena parent Column sudah rata kiri
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.location_on),
              label: const Text('Lokasi'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0D2C63),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              recipient.address ?? 'Alamat tidak tersedia',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOtherInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Informasi Lainnya',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 16),
        _buildInfoRow('Founder', recipient.founder ?? '-'),
        _buildInfoRow('Kontak Komunitas', recipient.contact ?? '-'),
        _buildInfoRow('Jumlah Anggota', recipient.memberCount ?? '-'),
      ],
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 13, color: Colors.grey)),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
