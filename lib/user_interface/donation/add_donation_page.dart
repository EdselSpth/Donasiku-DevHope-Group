// lib/user_interface/donation/add_donation_page.dart

import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

class AddDonationPage extends StatefulWidget {
  const AddDonationPage({super.key});

  @override
  State<AddDonationPage> createState() => _AddDonationPageState();
}

class _AddDonationPageState extends State<AddDonationPage> {
  // Controller untuk setiap text field
  final _productNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();

  @override
  void dispose() {
    // Selalu dispose controller setelah tidak digunakan
    _productNameController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          'Tambah Produk',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Image Uploader ---
              _buildImageUploader(),
              const SizedBox(height: 24),

              // --- Input Fields ---
              _buildTextField(
                label: 'Nama Produk',
                hint: 'Masukan nama produk',
                controller: _productNameController,
                maxLength: 22,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                label: 'Deskripsi Produk',
                hint: 'Masukan Deskripsi Produk',
                controller: _descriptionController,
                maxLength: 200,
                maxLines: 4, // Untuk area teks yang lebih besar
              ),
              const SizedBox(height: 16),
              _buildTextField(
                label: 'Masukan Lokasi',
                hint: 'Cari lokasi',
                controller: _locationController,
              ),
            ],
          ),
        ),
      ),
      // --- Bottom Action Buttons ---
      bottomNavigationBar: _buildBottomButtons(),
    );
  }

  Widget _buildImageUploader() {
    return DottedBorder(
      color: Colors.grey.shade400,
      strokeWidth: 1.5,
      dashPattern: const [8, 4],
      radius: const Radius.circular(12),
      borderType: BorderType.RRect,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 32),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.cloud_upload_outlined,
              size: 50,
              color: Colors.grey.shade500,
            ),
            const SizedBox(height: 8),
            const Text(
              'Tambahkan Foto Produk',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // TODO: Logika untuk upload file
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0D2C63),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text('UPLOAD FILE'),
            ),
          ],
        ),
      ),
    );
  }

  // Widget helper untuk membuat text field
  Widget _buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    int? maxLength,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLength: maxLength,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: const OutlineInputBorder(borderSide: BorderSide.none),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  Widget _buildBottomButtons() {
    return Container(
      padding: const EdgeInsets.all(24.0),
      color: Colors.grey[100],
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                // TODO: Logika untuk tombol Simpan
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0D2C63),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Simpan'),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: OutlinedButton(
              onPressed: () {
                // TODO: Logika untuk tombol Tampilkan
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF0D2C63),
                side: const BorderSide(color: Color(0xFF0D2C63), width: 1.5),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Tampilkan'),
            ),
          ),
        ],
      ),
    );
  }
}
