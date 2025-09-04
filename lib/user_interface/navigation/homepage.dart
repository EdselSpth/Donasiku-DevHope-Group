import 'package:flutter/material.dart';
import 'package:donasiku/models/donation_item.dart';
import 'package:donasiku/widget/donation_card.dart';

class HomePage extends StatelessWidget {
  final List<DonationItem> dummyItems = [
    DonationItem(
      title: 'Baju Pria Dewasa',
      location: 'Bojongsoang',
      imageUrl:
          'https://plus.unsplash.com/premium_photo-1674828600713-16a2346734d2?w=500',
    ),
    DonationItem(
      title: 'Sepatu',
      location: 'Bojongsoang',
      imageUrl:
          'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=500',
    ),
    DonationItem(
      title: 'Tas Sekolah Anak',
      location: 'Bojongsoang',
      imageUrl:
          'https://images.unsplash.com/photo-1553062407-98eeb68c6a62?w=500',
    ),
    DonationItem(
      title: 'Celana Pria',
      location: 'Bojongsoang',
      imageUrl:
          'https://images.unsplash.com/photo-1602293589914-9e1957a0a5c4?w=500',
    ),
  ];

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(children: [_buildHeader(), _buildBody()]),
      ),
    );
  }

  Widget _buildHeader() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 200,
          decoration: const BoxDecoration(
            color: Color(0xFF0D2C63),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.only(left: 24, right: 24, top: 50, bottom: 60),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Halo Zunadea!",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Donasi Apa Hari Ini ?",
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                  ],
                ),
                CircleAvatar(
                  radius: 24,
                  backgroundImage: NetworkImage(
                    'https://i.pravatar.cc/150?img=1',
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 140,
          left: 24,
          right: 24,
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Donasi Sekarang",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text("Donasi untuk melanjutkan"),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0D2C63),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text("Donasi"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 80,
        left: 24,
        right: 24,
      ),
      child: Column(
        children: [
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              side: BorderSide(color: Colors.grey[300]!),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Salurkan Donasi Melalui",
                    style: TextStyle(color: Colors.black),
                  ),
                  Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Disekitar mu",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextButton(onPressed: () {}, child: const Text("Lihat Semua")),
            ],
          ),
          const SizedBox(height: 8),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.8,
            ),
            itemCount: dummyItems.length,
            itemBuilder: (context, index) {
              final item = dummyItems[index];
              return DonationCard(
                item: item,
                onTap: () {},
              );
            },
          ),
        ],
      ),
    );
  }
}