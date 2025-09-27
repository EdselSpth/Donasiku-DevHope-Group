import 'package:donasiku/services/user/user_api_service.dart';
import 'package:flutter/material.dart';
import 'package:donasiku/user_interface/navigation/donation/donation_list_page.dart';
import 'package:donasiku/user_interface/recipients/recipient_list_page.dart';
import 'package:donasiku/user_interface/navigation/donation/donation_page.dart';
import 'package:donasiku/models/donation_item.dart';
import 'package:donasiku/widget/donation_card.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<DonationItem> dummyItems = [
    DonationItem(
      title: 'Baju Pria Dewasa',
      location: 'Bojongsoang',
      imageUrl: '',
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
      imageUrl: '',
    ),
    DonationItem(title: 'Celana Pria', location: 'Bojongsoang', imageUrl: ''),
  ];

  final UserService userService = UserService();
  Map<String, dynamic>? _user;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getUserProfile();
  }

  Future<void> _getUserProfile() async {
    try {
      final user = await userService.getProfile();
      setState(() {
        _user = user['user'];
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      // 1. GUNAKAN STACK UNTUK MENUMPUK WIDGET
      body: Stack(
        children: [
          // Konten body yang bisa di-scroll
          _buildBody(context),
          // Header yang diam dan berada di lapisan atas
          _buildHeader(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    // Header tidak berubah, tetap menggunakan Stack internal untuk kartu
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          height: 200,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xFF0D2C63),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _isLoading ? "Loading..." : "Halo ${_user?['username'] ?? 'User'}!",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        "Donasi Apa Hari Ini ?",
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 24,
                    backgroundImage: _user?['profile_url'] != null
                        ? NetworkImage(_user!['profile_url'])
                        : const NetworkImage(
                            'https://i.pravatar.cc/150?img=1',
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 140,
          left: 24,
          right: 24,
          child: Card(
            color: Colors.white,
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
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DonationPage()),
                      );
                    },
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

  Widget _buildBody(BuildContext context) {
    // 2. GUNAKAN SINGLECHILDSCROLLVIEW AGAR HANYA BAGIAN BODY YANG BISA DI-SCROLL
    return SingleChildScrollView(
      child: Padding(
        // 3. Padding atas diatur agar konten dimulai di bawah header
        padding: const EdgeInsets.only(
          top: 240,
          left: 24,
          right: 24,
          bottom: 24,
        ),
        child: Column(
          children: [
            OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RecipientListPage()),
                );
              },
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white,
                elevation: 2,
                shadowColor: Colors.black.withOpacity(0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                side: BorderSide(color: Colors.grey[300]!),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  children: [
                    Image.asset(
                      'Assets/komunitas.png',
                      width: 24,
                      height: 24,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.image_not_supported,
                          color: Colors.grey,
                          size: 24,
                        );
                      },
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        "Salurkan Donasi Melalui",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Disekitar mu",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DonationListPage(),
                      ),
                    );
                  },
                  child: const Text("Lihat Semua"),
                ),
              ],
            ),
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
                return DonationCard(item: item, onTap: () {});
              },
            ),
          ],
        ),
      ),
    );
  }
}
