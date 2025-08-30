import 'package:donasiku/models/donation_item.dart'; // Import model yang tadi dibuat
import 'package:flutter/material.dart';

class DonationCard extends StatelessWidget {
  final DonationItem item;
  final VoidCallback onTap;

  const DonationCard({super.key, required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      // Card sebagai container utama dengan bayangan dan sudut tumpul
      clipBehavior:
          Clip.antiAlias, // Memastikan konten di dalamnya mengikuti bentuk card
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      elevation: 4,
      child: InkWell(
        // InkWell agar card bisa diklik dan ada efek ripple
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bagian Gambar
            Expanded(
              child: Image.network(
                item.imageUrl,
                width: double.infinity,
                fit: BoxFit.cover, // Agar gambar memenuhi area tanpa distorsi
                // Placeholder saat gambar sedang dimuat
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
                // Tampilan jika gagal memuat gambar
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(Icons.broken_image, color: Colors.grey),
                  );
                },
              ),
            ),

            // Bagian Teks di bawah gambar
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: Colors.grey[600],
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        item.location,
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
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
