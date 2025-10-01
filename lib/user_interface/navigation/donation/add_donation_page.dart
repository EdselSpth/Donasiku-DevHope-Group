// lib/user_interface/donation/add_donation_page.dart

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

import 'package:donasiku/user_interface/location/location_picker_page.dart';

class Category {
  final int id;
  final String name;

  Category({required this.id, required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(id: json['category_id'], name: json['name']);
  }
}

class AddDonationPage extends StatefulWidget {
  const AddDonationPage({super.key});

  @override
  State<AddDonationPage> createState() => _AddDonationPageState();
}

class _AddDonationPageState extends State<AddDonationPage> {
  final _formKey = GlobalKey<FormState>();
  final _productNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  File? _imageFile;
  final _picker = ImagePicker();
  final _storage = const FlutterSecureStorage();
  String? _selectedLocation;

  List<Category> _categories = [];
  int? _selectedCategoryId;
  bool _isLoadingCategories = true;

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    print('[ADD_DONATION] Fetching categories...');
    setState(() {
      _isLoadingCategories = true;
    });
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:3000/category'),
      );
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        setState(() {
          _categories = data.map((json) => Category.fromJson(json)).toList();
          _isLoadingCategories = false;
        });
        print('[ADD_DONATION] Categories fetched successfully.');
      } else {
        print(
          '[ADD_DONATION] Failed to fetch categories: ${response.statusCode}',
        );
        setState(() {
          _isLoadingCategories = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to load categories from server.'),
          ),
        );
      }
    } catch (e) {
      print('[ADD_DONATION] Error fetching categories: $e');
      setState(() {
        _isLoadingCategories = false;
      });
      String errorMessage = 'Gagal memuat kategori. Silakan coba lagi.';
      if (e is http.ClientException) {
        errorMessage =
            'Tidak dapat terhubung ke server. Pastikan server backend berjalan.';
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(errorMessage)));
    }
  }

  Future<void> _pickImage() async {
    print('[ADD_DONATION] _pickImage called');
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        print('[ADD_DONATION] Image picked: ${pickedFile.path}');
        setState(() {
          _imageFile = File(pickedFile.path);
        });
      } else {
        print('[ADD_DONATION] Image picking cancelled.');
      }
    } catch (e) {
      print('[ADD_DONATION] Error picking image: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error picking image: $e')));
    }
  }

  Future<void> _uploadDonation() async {
    print('[ADD_DONATION] _uploadDonation called');
    if (!_formKey.currentState!.validate() ||
        _imageFile == null ||
        _selectedLocation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all fields, select an image, and choose a location.'),
        ),
      );
      return;
    }

    const String apiUrl = 'http://10.0.2.2:3000/donate/items';
    print('[ADD_DONATION] API URL: $apiUrl');

    final token = await _storage.read(key: 'accessToken');
    if (token == null) {
      print('[ADD_DONATION] Auth token is null.');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Authentication token not found. Please log in again.'),
        ),
      );
      return;
    }
    print('[ADD_DONATION] Auth token found.');

    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
    request.headers['Authorization'] = 'Bearer $token';

    final fields = {
      'name': _productNameController.text,
      'description': _descriptionController.text,
      'address': _selectedLocation!,
      'category_id': _selectedCategoryId.toString(),
      'quantity': '1',
      'area_id': '1',
    };
    request.fields.addAll(fields);
    print('[ADD_DONATION] Request fields: $fields');

    print('[ADD_DONATION] Attaching image file: ${_imageFile!.path}');
    final mimeType = lookupMimeType(_imageFile!.path);
    if (mimeType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Could not determine file type. Please select another image.',
          ),
        ),
      );
      return;
    }

    final mimeTypeData = mimeType.split('/');

    request.files.add(
      await http.MultipartFile.fromPath(
        'image',
        _imageFile!.path,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]),
      ),
    );

    try {
      print('[ADD_DONATION] Sending request...');
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      print('[ADD_DONATION] Response status code: ${response.statusCode}');
      print('[ADD_DONATION] Response body: ${response.body}');

      if (response.statusCode == 201) {
        print('[ADD_DONATION] Donation added successfully!');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Donation added successfully!')),
        );
        Navigator.pop(context);
      } else {
        final responseData = json.decode(response.body);
        print(
          '[ADD_DONATION] Failed to add donation: ${responseData['message']}',
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to add donation: ${responseData['message']}'),
          ),
        );
      }
    } catch (e) {
      print('[ADD_DONATION] An error occurred: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('An error occurred: $e')));
    }
  }

  @override
  void dispose() {
    _productNameController.dispose();
    _descriptionController.dispose();
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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildImageUploader(),
                const SizedBox(height: 24),
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
                  maxLines: 4,
                ),
                const SizedBox(height: 16),
                _buildCategoryDropdown(),
                const SizedBox(height: 16),
                _buildLocationPicker(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomButtons(),
    );
  }

  Widget _buildLocationPicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Lokasi',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LocationPickerPage(),
              ),
            );
            if (result != null && result is String) {
              setState(() {
                _selectedLocation = result;
              });
            }
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    _selectedLocation ?? 'Pilih lokasi',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: _selectedLocation == null
                          ? Colors.grey.shade600
                          : Colors.black,
                    ),
                  ),
                ),
                const Icon(Icons.arrow_drop_down, color: Colors.grey),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryDropdown() {
    if (_isLoadingCategories) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_categories.isEmpty) {
      return TextFormField(
        readOnly: true,
        decoration: InputDecoration(
          labelText: 'Kategori',
          hintText: 'Tidak ada kategori ditemukan',
          border: const OutlineInputBorder(borderSide: BorderSide.none),
          filled: true,
          fillColor: Colors.grey[200],
        ),
      );
    }

    return DropdownButtonFormField<int>(
      value: _selectedCategoryId,
      hint: const Text('Pilih Kategori'),
      items:
          _categories.map((Category category) {
            return DropdownMenuItem<int>(
              value: category.id,
              child: Text(category.name),
            );
          }).toList(),
      onChanged: (int? newValue) {
        setState(() {
          _selectedCategoryId = newValue;
        });
      },
      validator:
          (value) => value == null ? 'Kategori tidak boleh kosong' : null,
      decoration: InputDecoration(
        labelText: 'Kategori',
        border: const OutlineInputBorder(borderSide: BorderSide.none),
        filled: true,
        fillColor: Colors.white,
      ),
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
        child:
            _imageFile == null
                ? Column(
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
                      onPressed: _pickImage,
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
                )
                : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.file(_imageFile!, height: 150),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: _pickImage,
                      child: const Text('Ganti Gambar'),
                    ),
                  ],
                ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    int? maxLength,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
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
      validator:
          validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return '$label tidak boleh kosong';
            }
            return null;
          },
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
              onPressed: _uploadDonation,
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
