import 'dart:convert';

import 'package:donasiku/user_interface/navigation/donation/item_request_list_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ItemRequestPage extends StatefulWidget {
  const ItemRequestPage({super.key});

  @override
  State<ItemRequestPage> createState() => _ItemRequestPageState();
}

class _ItemRequestPageState extends State<ItemRequestPage> {
  final _itemNameController = TextEditingController();
  final _quantityController = TextEditingController();
  final _originController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _storage = const FlutterSecureStorage();

  Future<void> _submitRequest() async {
    if (_itemNameController.text.isEmpty ||
        _quantityController.text.isEmpty ||
        _originController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields.')),
      );
      return;
    }

    // TODO: Replace with your actual IP address
    const String apiUrl = 'http://localhost:3000/donate/requests';
    final token = await _storage.read(key: 'token');

    final message =
        '${_itemNameController.text} - ${_descriptionController.text}';

    final body = {
      // TODO: These are mocked values. Replace with actual data from your app.
      'category_id': '1',
      'message': message,
      'quantity': _quantityController.text,
      'area_id': '1',
      'address': _originController.text,
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(body),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Request submitted successfully!')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ItemRequestListPage()),
        );
      } else {
        final responseData = json.decode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed to submit request: ${responseData['message']}',
            ),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('An error occurred: $e')));
    }
  }

  @override
  void dispose() {
    _itemNameController.dispose();
    _quantityController.dispose();
    _originController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Stack(
        children: [
          ClipPath(
            clipper: HeaderClipper(),
            child: Container(height: 150, color: const Color(0xFF0D2C63)),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  _buildCustomAppBar(context),
                  const SizedBox(height: 20),
                  _buildInfoCard(),
                  const SizedBox(height: 20),
                  _buildFormCard(context),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomAppBar(BuildContext context) {
    return Row(
      children: [
        BackButton(
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
        ),
        const Expanded(
          child: Text(
            'Permintaan Barang',
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
    );
  }

  Widget _buildInfoCard() {
    return Card(
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Image.asset(
              'Assets/gambar-permintaan-barang.png',
              width: 50,
              height: 50,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Permintaan Barang',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF0D2C63),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Kami menerima permintaan dari pengguna dan kami memastikan kebutuhan terpenuhi sesuai dengan permintaan.',
                    style: TextStyle(color: Colors.grey[600], fontSize: 13),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormCard(BuildContext context) {
    return Card(
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _buildTextFieldWithLabel(
              label: 'Nama Barang',
              hint: 'Contoh: Pakaian Anak Pria',
              controller: _itemNameController,
            ),
            const SizedBox(height: 16),
            _buildTextFieldWithLabel(
              label: 'Jumlah/Kebutuhan',
              hint: 'Masukan Jumlah',
              controller: _quantityController,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            _buildTextFieldWithLabel(
              label: 'Darimana anda berasal',
              hint: 'Contoh: komunitas, panti asuhan & jompo',
              controller: _originController,
            ),
            const SizedBox(height: 16),
            _buildTextFieldWithLabel(
              label: 'Deskripsi Tambahan',
              hint: 'Tuliskan detail kebutuhan Anda....',
              controller: _descriptionController,
              maxLines: 4,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitRequest,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0D2C63),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Ajukan Permintaan',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFieldWithLabel({
    required String label,
    required String hint,
    required TextEditingController controller,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey[400]),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
          ),
        ),
      ],
    );
  }
}

class HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 40);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - 40,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
