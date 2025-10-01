import 'package:flutter/material.dart';

class VerificationFormScreen extends StatefulWidget {
  const VerificationFormScreen({Key? key}) : super(key: key);

  @override
  State<VerificationFormScreen> createState() => _VerificationFormScreenState();
}

class _VerificationFormScreenState extends State<VerificationFormScreen> {
  // Controller untuk setiap field
  final _nikController = TextEditingController();
  final _nameController = TextEditingController();
  final _birthPlaceDateController = TextEditingController();
  final _religionController = TextEditingController();
  final _addressController = TextEditingController();
  final _genderController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _reasonController = TextEditingController();

  @override
  void dispose() {
    // Jangan lupa dispose semua controller
    _nikController.dispose();
    _nameController.dispose();
    _birthPlaceDateController.dispose();
    _religionController.dispose();
    _addressController.dispose();
    _genderController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Verifikasi KTP'),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        foregroundColor: Colors.black,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Image.asset(
                  'Assets/Logo-Donasiku.png', // Pastikan path logo benar
                  height: 40,
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'Lengkapi Data Yuk!',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D2C63),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Lengkapi data yang diperlukan ya, isi data yang kosong dan benarkan apabila data salah!',
                style: TextStyle(color: Colors.grey[600]),
              ),
              const SizedBox(height: 24),
              _buildTextField(
                label: 'Nomor Induk Kependudukan (NIK)',
                hint: 'NIK Kamu',
                controller: _nikController,
                keyboardType: TextInputType.number,
              ),
              _buildTextField(
                label: 'Nama Sesuai KTP',
                hint: 'Nama Kamu',
                controller: _nameController,
              ),
              _buildTextField(
                label: 'Tempat, Tanggal Lahir',
                hint: 'Tempat, DD - MM - YY',
                controller: _birthPlaceDateController,
              ),
              _buildTextField(
                label: 'Agama',
                hint: 'Islam',
                controller: _religionController,
              ),
              _buildTextField(
                label: 'Alamat Lengkap',
                hint: 'Alamat Kamu',
                controller: _addressController,
              ),
              _buildTextField(
                label: 'Jenis Kelamin',
                hint: 'Laki-Laki',
                controller: _genderController,
              ),
              _buildTextField(
                label: 'Alamat Email',
                hint: 'example@gmail.com',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              _buildTextField(
                label: 'Nomor Handphone',
                hint: '0821 - 2837 - 0932',
                controller: _phoneController,
                keyboardType: TextInputType.phone,
              ),
              _buildTextField(
                label: 'Alasan Bergabung',
                hint: 'Tuliskan alasannya ya!',
                controller: _reasonController,
                maxLines: 3,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  // TODO: Tambahkan logika untuk tombol Lanjutkan
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: const Color(0xFF0D2C63),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Lanjutkan',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget helper untuk membuat form field agar tidak repetitif
  Widget _buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            keyboardType: keyboardType,
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: hint,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }
}