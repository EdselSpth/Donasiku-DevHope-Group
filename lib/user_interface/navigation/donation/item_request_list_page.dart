import 'package:flutter/material.dart';

class ItemRequestListPage extends StatelessWidget {
  const ItemRequestListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Request List'),
      ),
      body: const Center(
        child: Text('Item Request List Page'),
      ),
    );
  }
}