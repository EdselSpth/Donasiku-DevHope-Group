// lib/widget/donation_card.dart

import 'package:donasiku/models/donation_item.dart';
import 'package:flutter/material.dart';

class DonationCard extends StatelessWidget {
  final DonationItem item;
  final VoidCallback onTap;

  const DonationCard({super.key, required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      // --- PERUBAHAN DI SINI ---
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0), // Sudut lebih bulat
      ),
      elevation: 4, // Sedikit naikkan elevation untuk bayangan
      shadowColor: Colors.black.withOpacity(0.1), // Bayangan lebih halus
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Image.network(
                item.imageUrl,
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: Container(
                      // Placeholder dengan warna
                      color: Colors.grey[200],
                      child: const Icon(Icons.image, color: Colors.grey),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Container(
                      color: Colors.grey[200],
                      child: const Icon(Icons.broken_image, color: Colors.grey),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: Colors.blueAccent,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        item.location,
                        style: TextStyle(fontSize: 13, color: Colors.grey[600]),
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
