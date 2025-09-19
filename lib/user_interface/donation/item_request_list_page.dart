// lib/user_interface/donation/item_request_list_page.dart

import 'package:donasiku/models/item_request_model.dart';
import 'package:donasiku/widget/item_request_card.dart';
import 'package:flutter/material.dart';

class ItemRequestListPage extends StatefulWidget {
  const ItemRequestListPage({super.key});

  @override
  State<ItemRequestListPage> createState() => _ItemRequestListPageState();
}

class _ItemRequestListPageState extends State<ItemRequestListPage> {
  // State untuk filter yang aktif
  int _selectedFilterIndex = 0;
  final List<String> _filters = [
    'All',
    'Komunitas',
    'Panti Asuhan',
    'Panti Jompo',
  ];

  // Dummy data
  final List<ItemRequestModel> _requests = [
    ItemRequestModel(
      requesterLogoUrl:
          'Assets/dinsos_logo.png', // Pastikan Anda punya aset ini
      itemName: 'Pakaian Anak',
      recipient: 'Panti Asuhan Ceria Bandung',
      location: 'JL. Pandjaitan Bandung',
    ),
    ItemRequestModel(
      requesterLogoUrl: 'Assets/dinsos_logo.png',
      itemName: 'Buku Pelajaran SMA',
      recipient: 'Komunitas Belajar Bersama',
      location: 'Gedung Pemuda Jakarta',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFilters(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              'Item',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _requests.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: ItemRequestCard(request: _requests[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFF0D2C63),
      leading: const BackButton(color: Colors.white),
      title: const Text(
        'Permintaan Barang',
        style: TextStyle(color: Colors.white),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: CircleAvatar(
            radius: 18,
            backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=12'),
          ),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ).copyWith(bottom: 12),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Cari barang atau penerima',
                    hintStyle: TextStyle(color: Colors.grey[600]),
                    prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.zero,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: IconButton(
                  icon: const Icon(Icons.filter_list, color: Color(0xFF0D2C63)),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
    );
  }

  Widget _buildFilters() {
    return SizedBox(
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
              selectedColor: const Color(0xFF0D2C63).withOpacity(0.1),
              labelStyle: TextStyle(
                color: isSelected ? const Color(0xFF0D2C63) : Colors.black,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color:
                      isSelected
                          ? const Color(0xFF0D2C63)
                          : Colors.grey.shade300,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
