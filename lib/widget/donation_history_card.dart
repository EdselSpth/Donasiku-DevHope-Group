// lib/widget/donation_history_card.dart

import 'package:flutter/material.dart';
import 'package:donasiku/models/history_model.dart';

class DonationHistoryCard extends StatelessWidget {
  final DonationHistoryModel historyItem;

  const DonationHistoryCard({super.key, required this.historyItem});

  // Helper widget untuk membuat label status donasi
  Widget _buildStatusChip(DonationStatus status) {
    Color chipColor;
    String statusText;

    switch (status) {
      case DonationStatus.Selesai:
        chipColor = Colors.green;
        statusText = 'Selesai';
        break;
      case DonationStatus.Dikirim:
        chipColor = Colors.orange;
        statusText = 'Dikirim';
        break;
      case DonationStatus.Dibatalkan:
        chipColor = Colors.red;
        statusText = 'Dibatalkan';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: chipColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        statusText,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Helper untuk membuat baris info
  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100, // Memberi lebar tetap agar rapi
            child: Text(title, style: TextStyle(color: Colors.grey[600])),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: Colors.grey.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(
                          historyItem.profileImageUrl,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Nama Pendonasi",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              historyItem.donorName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                _buildStatusChip(historyItem.status),
              ],
            ),
            const Divider(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // FIX #1: Menggunakan Expanded dengan flex untuk membagi ruang
                Expanded(
                  flex: 3, // Memberi porsi ruang lebih besar
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoRow("Role Akun", historyItem.role),
                      _buildInfoRow("Tujuan Donasi", historyItem.destination),
                      _buildInfoRow("Jumlah Barang", historyItem.quantity),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 2, // Memberi porsi ruang lebih kecil
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Nama Barang",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      Text(
                        historyItem.itemName,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      if (historyItem.itemImageUrl != null)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          // FIX #2: Menambahkan errorBuilder untuk menangani gambar yang gagal dimuat
                          child: Image.network(
                            historyItem.itemImageUrl!,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              // Tampilkan ini jika gambar error
                              return Container(
                                width: 80,
                                height: 80,
                                color: Colors.grey[200],
                                child: Icon(
                                  Icons.broken_image_outlined,
                                  color: Colors.grey[400],
                                ),
                              );
                            },
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
