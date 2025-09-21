// lib/user_interface/recipients/recipient_category_list_page.dart

import 'package:donasiku/models/recipient_model.dart';
import 'package:donasiku/user_interface/recipients/recipient_detail_page.dart';
import 'package:donasiku/widget/recipient_card.dart';
import 'package:flutter/material.dart';

class RecipientCategoryListPage extends StatelessWidget {
  final String title;
  final List<RecipientModel> recipients;

  const RecipientCategoryListPage({
    super.key,
    required this.title,
    required this.recipients,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: CustomScrollView(
        slivers: [
          // Header
          SliverAppBar(
            backgroundColor: const Color(0xFF0D2C63),
            leading: const BackButton(color: Colors.white),
            title: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            pinned: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(70),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Cari nama berbagai kalangan',
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
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
            ),
          ),

          // Daftar Kartu
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: RecipientCard(
                    logoUrl: recipients[index].logoUrl,
                    name: recipients[index].name,
                    description: recipients[index].description,
                    isVerified: recipients[index].isVerified,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              RecipientDetailPage(recipient: recipients[index]),
                        ),
                      );
                    },
                  ),
                );
              }, childCount: recipients.length),
            ),
          ),
        ],
      ),
    );
  }
}
