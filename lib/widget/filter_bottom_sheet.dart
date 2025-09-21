// lib/widget/filter_bottom_sheet.dart

import 'package:donasiku/user_interface/location/location_picker_page.dart'; // 1. Import halaman lokasi
import 'package:flutter/material.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  final Map<String, bool> _categories = {
    'Baju': false,
    'Celana': false,
    'Tas': true,
    'Sepatu': false,
  };

  int _sortOptionIndex = 0;
  String _selectedLocation = 'Bandung';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ... (Header dan bagian lain tidak berubah)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Filter',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildCategorySection(),
            const SizedBox(height: 24),
            const Text(
              'Pilih dari opsi dibawah ini',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            _buildSortOptions(),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  // Widget untuk bagian Kategori
  Widget _buildCategorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Kategori Barang',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(width: 8),

            // --- PERUBAHAN DI SINI ---
            // 1. Bungkus dengan Expanded agar tombol mengisi sisa ruang
            Expanded(
              child: InkWell(
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
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize:
                        MainAxisSize.min, // Agar row tidak memakan semua tempat
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 16,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      // 2. Bungkus Text dengan Flexible agar bisa menampilkan elipsis
                      Flexible(
                        child: Text(
                          _selectedLocation,
                          overflow:
                              TextOverflow
                                  .ellipsis, // Tampilkan "..." jika teks panjang
                          maxLines: 1,
                        ),
                      ),
                      const Icon(Icons.arrow_drop_down, color: Colors.grey),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        // ... (Sisa kode checkbox tidak berubah)
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(child: _buildCheckbox('Baju')),
            Expanded(child: _buildCheckbox('Celana')),
          ],
        ),
        Row(
          children: [
            Expanded(child: _buildCheckbox('Tas')),
            Expanded(child: _buildCheckbox('Sepatu')),
          ],
        ),
      ],
    );
  }

  // ... (sisa kode _buildCheckbox dan _buildSortOptions tidak berubah)
  Widget _buildCheckbox(String title) {
    return InkWell(
      onTap: () {
        setState(() {
          _categories[title] = !_categories[title]!;
        });
      },
      child: Row(
        children: [
          Checkbox(
            value: _categories[title],
            onChanged: (bool? value) {
              setState(() {
                _categories[title] = value!;
              });
            },
          ),
          Text(title),
        ],
      ),
    );
  }

  Widget _buildSortOptions() {
    return Wrap(
      spacing: 8.0,
      children: [
        ChoiceChip(
          label: const Text('Tanggal diterbitkan'),
          selected: _sortOptionIndex == 0,
          onSelected: (selected) {
            if (selected) {
              setState(() => _sortOptionIndex = 0);
            }
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: Colors.grey.shade300),
          ),
          showCheckmark: false,
        ),
        ChoiceChip(
          label: const Text('Jarak'),
          selected: _sortOptionIndex == 1,
          onSelected: (selected) {
            if (selected) {
              setState(() => _sortOptionIndex = 1);
            }
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: Colors.grey.shade300),
          ),
          showCheckmark: false,
        ),
      ],
    );
  }
}
