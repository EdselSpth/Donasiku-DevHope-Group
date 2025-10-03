import 'package:donasiku/user_interface/navigation/donation/donation_detail_page.dart';
import 'package:donasiku/models/donation_item.dart';
import 'package:donasiku/models/history_model.dart';
import 'package:donasiku/services/donation_service.dart';
import 'package:donasiku/widget/donation_card.dart';
import 'package:flutter/material.dart';

// 1. BUAT CLASS HELPER BARU DI DALAM FILE YANG SAMA
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final Widget _tabBar;

  @override
  double get minExtent => 60; // Tinggi minimal saat di-scroll
  @override
  double get maxExtent => 60; // Tinggi maksimal saat normal

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: const Color(0xFFF8F9FA), // Samakan dengan background body
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

class DonationListPage extends StatefulWidget {
  const DonationListPage({super.key});

  @override
  State<DonationListPage> createState() => _DonationListPageState();
}

class _DonationListPageState extends State<DonationListPage> {
  int _selectedFilterIndex = 0;
  final List<String> _filters = ['All', 'Baju', 'Celana', 'Elektro', 'Sport'];

  final DonationService donationService = DonationService();
  late Future<List<DonationHistoryModel>> _donationHistoryFuture;

  @override
  void initState() {
    super.initState();
    _donationHistoryFuture = donationService.getActiveDonations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: NestedScrollView(
        // --- PERUBAHAN UTAMA DI SINI ---
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: const Color(0xFF0D2C63),
              leading: const BackButton(color: Colors.white),
              pinned: true,
              floating: false, // Floating dimatikan agar lebih stabil
              title: const Text(
                'Barang Donasiku',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(110),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: InkWell(
                        onTap: () {
                          /* Logika buka picker lokasi */
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 16,
                                color: Colors.grey[700],
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Bandung',
                                style: TextStyle(
                                  color: Colors.grey[800],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Icon(
                                Icons.arrow_drop_down,
                                color: Colors.grey[700],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Cari barang yang kamu inginkan',
                                prefixIcon: const Icon(
                                  Icons.search,
                                  color: Colors.grey,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: EdgeInsets.zero,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.filter_list,
                                color: Color(0xFF0D2C63),
                              ),
                              onPressed: () {
                                /* Logika buka filter */
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // 2. TAMBAHKAN SLIVER BARU UNTUK FILTER
            SliverPersistentHeader(
              delegate: _SliverAppBarDelegate(
                _buildFilters(), // Masukkan widget filter ke delegate
              ),
              pinned: true, // "Tempelkan" di atas
            ),
          ];
        },
        // 3. BODY SEKARANG HANYA BERISI GRIDVIEW
        body: FutureBuilder<List<DonationHistoryModel>>(
          future: _donationHistoryFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (snapshot.hasData) {
              final items = snapshot.data!;
              return GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.8,
                ),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final historyItem = items[index];
                  final donationItem = DonationItem(
                    id: historyItem.itemId,
                    title: historyItem.itemName,
                    location: historyItem.destination,
                    imageUrl: historyItem.itemImageUrl ?? '',
                    description: historyItem.description,
                    owner: historyItem.donorName,
                  );
                  return DonationCard(
                    item: donationItem,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => DonationDetailPage(
                                item: donationItem,
                                donationId: donationItem.id,
                              ),
                        ),
                      );
                    },
                  );
                },
              );
            } else {
              return const Center(child: Text("No donation items found."));
            }
          },
        ),
      ),
    );
  }

  Widget _buildFilters() {
    // ... (kode _buildFilters tidak berubah)
    return Container(
      color: const Color(0xFFF8F9FA),
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemCount: _filters.length,
        itemBuilder: (context, index) {
          final isSelected = _selectedFilterIndex == index;
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ChoiceChip(
              label: Text(_filters[index]),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  _selectedFilterIndex = index;
                });
              },
              backgroundColor: Colors.white,
              selectedColor: const Color(0xFF0D2C63),
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.black54,
                fontWeight: FontWeight.bold,
              ),
              avatar:
                  isSelected
                      ? const Icon(Icons.check, color: Colors.white, size: 16)
                      : null,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side:
                    isSelected
                        ? BorderSide.none
                        : BorderSide(color: Colors.grey.shade300),
              ),
              showCheckmark: false,
            ),
          );
        },
      ),
    );
  }
}
