// lib/user_interface/navigation/history_page.dart

import 'package:flutter/material.dart';
import 'package:donasiku/models/history_model.dart';
import 'package:donasiku/widget/chat_list_item.dart';
import 'package:donasiku/widget/donation_history_card.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // ... (Data dummy tidak perlu diubah) ...
  final List<DonationHistoryModel> donationHistory = [
    DonationHistoryModel(
      profileImageUrl: 'https://i.pravatar.cc/150?img=12',
      donorName: 'Zunadea Kusmiandita',
      role: 'Donatur',
      destination:
          'Panti Asuhan Al - Ghifari yang sangat panjang sekali namanya',
      quantity: '1 Pcs',
      itemName: 'Tas Dewasa',
      itemImageUrl: 'https://ini-url-yang-salah.com/gambar.png',
      status: DonationStatus.Selesai,
    ),
    DonationHistoryModel(
      profileImageUrl: 'https://i.pravatar.cc/150?img=12',
      donorName: 'Zunadea Kusmiandita',
      role: 'Donatur',
      destination: 'Panti Asuhan Al - Ghifari',
      quantity: '1 Pcs',
      itemName: 'Baju Dewasa Pria',
      status: DonationStatus.Dikirim,
    ),
    DonationHistoryModel(
      profileImageUrl: 'https://i.pravatar.cc/150?img=12',
      donorName: 'Zunadea Kusmiandita',
      role: 'Donatur',
      destination: 'Tujuan Donasi',
      quantity: '1 Pcs',
      itemName: 'Baju Dewasa Pria',
      status: DonationStatus.Dibatalkan,
    ),
  ];
  final List<ChatHistoryModel> chatHistory = [
    ChatHistoryModel(
      profileImageUrl: 'https://i.pravatar.cc/150?img=1',
      name: 'Kak Dias',
      lastMessage: 'Halo Devhope',
      timestamp: '9:40 AM',
    ),
    ChatHistoryModel(
      profileImageUrl: 'https://i.pravatar.cc/150?img=32',
      name: 'Edsel',
      lastMessage: 'Ok, Halo semua',
      timestamp: '9:25 AM',
      isYou: true,
    ),
    ChatHistoryModel(
      profileImageUrl: 'https://i.pravatar.cc/150?img=31',
      name: 'Nabil',
      lastMessage: 'Salam kenal ya...',
      timestamp: 'Fri',
      isYou: true,
    ),
    ChatHistoryModel(
      profileImageUrl: 'https://i.pravatar.cc/150?img=35',
      name: 'Firdha',
      lastMessage: 'Selamat berlibur!',
      timestamp: 'Fri',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              floating: true,
              backgroundColor: const Color(0xFF0D2C63),
              automaticallyImplyLeading: false,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
              elevation: 0,
              toolbarHeight: 120,
              flexibleSpace: SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          const BackButton(color: Colors.white),
                          const Expanded(
                            child: Text(
                              'Riwayat',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 48),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: TabBar(
                          controller: _tabController,
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.black,
                          indicatorSize: TabBarIndicatorSize.tab,
                          // --- FIX #2: HILANGKAN GARIS BAWAH TABBAR ---
                          dividerColor: Colors.transparent,
                          indicator: BoxDecoration(
                            color: const Color(0xFF0D2C63),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          tabs: const [
                            Tab(text: 'Riwayat Barang'),
                            Tab(text: 'Riwayat Chat'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [_buildDonationHistoryList(), _buildChatHistoryList()],
        ),
      ),
    );
  }

  Widget _buildDonationHistoryList() {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      itemCount: donationHistory.length,
      itemBuilder: (context, index) {
        return DonationHistoryCard(historyItem: donationHistory[index]);
      },
    );
  }

  Widget _buildChatHistoryList() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: chatHistory.length,
            itemBuilder: (context, index) {
              return ChatListItem(chatItem: chatHistory[index]);
            },
          ),
        ),
      ],
    );
  }
}
