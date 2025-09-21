import 'package:donasiku/models/recipient_model.dart';
import 'package:donasiku/user_interface/recipients/recipient_detail_page.dart'; // 1. Import halaman detail
import 'package:flutter/material.dart';

class RecipientCard extends StatelessWidget {
  // ... (properti widget tidak berubah)
  final String logoUrl;
  final String name;
  final String description;
  final bool isVerified;
  final VoidCallback onTap;

  const RecipientCard({
    super.key,
    required this.logoUrl,
    required this.name,
    required this.description,
    this.isVerified = true,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.grey[200],
                  backgroundImage: AssetImage(logoUrl),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color:
                              isVerified
                                  ? Colors.blue.shade50
                                  : Colors.orange.shade50,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          isVerified ? 'Terverifikasi' : 'Belum Terverifikasi',
                          style: TextStyle(
                            color:
                                isVerified
                                    ? Colors.blue.shade700
                                    : Colors.orange.shade700,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              description,
              style: TextStyle(color: Colors.grey[700], fontSize: 13),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: onTap,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0D2C63),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Detail'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
