import 'dart:convert';
import 'package:donasiku/models/item_request_model.dart';
import 'package:donasiku/widget/filter_bottom_sheet.dart';
import 'package:donasiku/widget/item_request_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Model baru yang cocok dengan response API
class ApiRequest {
  final int requestId;
  final String status;
  final String message;
  final int quantity;
  final String address;
  final DateTime createdAt;
  final String userName;

  ApiRequest({
    required this.requestId,
    required this.status,
    required this.message,
    required this.quantity,
    required this.address,
    required this.createdAt,
    required this.userName,
  });

  factory ApiRequest.fromJson(Map<String, dynamic> json) {
    return ApiRequest(
      requestId: json['request_id'] ?? 0,
      status: json['status'] ?? 'Pending',
      message: json['message'] ?? '',
      quantity: json['quantity'] ?? 0,
      address: json['address'] ?? 'No address',
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : DateTime.now(),
      userName: json['user']?['name'] ?? 'Unknown User',
    );
  }
}

class ItemRequestListPage extends StatefulWidget {
  const ItemRequestListPage({super.key});

  @override
  State<ItemRequestListPage> createState() => _ItemRequestListPageState();
}

class _ItemRequestListPageState extends State<ItemRequestListPage> {
  final List<String> _filters = ['All', 'Komunitas', 'Panti Asuhan', 'Panti Jompo'];
  int _selectedFilterIndex = 0;
  late Future<List<ApiRequest>> _requestsFuture;
  final _storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _requestsFuture = _fetchRequests();
  }

  Future<List<ApiRequest>> _fetchRequests() async {
    final token = await _storage.read(key: 'accessToken');
    if (token == null) {
      // Handle token not found, maybe pop back to login
      throw Exception('Authentication Token not found');
    }

    final response = await http.get(
      Uri.parse('http://10.0.2.2:3000/donate/requests'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> requestList = data['requests'];
      return requestList.map((json) => ApiRequest.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load requests');
    }
  }

  ItemRequestModelDetail _mapApiRequestToModelDetail(ApiRequest apiRequest) {
    String itemName = 'Unknown Item';
    String description = apiRequest.message;

    List<String> messageParts = apiRequest.message.split(' - ');
    if (messageParts.length > 1) {
      itemName = messageParts.first;
      description = messageParts.sublist(1).join(' - ');
    }

    return ItemRequestModelDetail(
      requesterLogoUrl: 'Assets/dinsos_logo.png', // Placeholder
      itemName: itemName,
      recipient: apiRequest.userName,
      location: apiRequest.address,
      quantity: '${apiRequest.quantity} Pcs',
      description: description,
    );
  }

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
            child: FutureBuilder<List<ApiRequest>>(
              future: _requestsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No requests found.'));
                } else {
                  final requests = snapshot.data!;
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: requests.length,
                    itemBuilder: (context, index) {
                      final requestModelDetail = _mapApiRequestToModelDetail(requests[index]);
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: ItemRequestCard(request: requestModelDetail),
                      );
                    },
                  );
                }
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
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 16.0),
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
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      builder: (context) {
                        return const FilterBottomSheet();
                      },
                    );
                  },
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
                      isSelected ? const Color(0xFF0D2C63) : Colors.grey.shade300,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}