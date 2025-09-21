// lib/user_interface/location/location_picker_page.dart
import 'package:donasiku/models/location_model.dart';
import 'package:donasiku/services/location/location_api_services.dart';
import 'package:flutter/material.dart';
import 'province_detail_page.dart';

class LocationPickerPage extends StatefulWidget {
  const LocationPickerPage({super.key});
  @override
  State<LocationPickerPage> createState() => _LocationPickerPageState();
}

class _LocationPickerPageState extends State<LocationPickerPage> {
  final LocationApiService _apiService = LocationApiService();
  late Future<List<Location>> _provincesFuture;

  @override
  void initState() {
    super.initState();
    _provincesFuture = _apiService.getProvinces();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pilih Provinsi')),
      body: FutureBuilder<List<Location>>(
        future: _provincesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final province = snapshot.data![index];
                return ListTile(
                  title: Text(province.name),
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => ProvinceDetailPage(province: province),
                      ),
                    );
                    if (result != null) {
                      Navigator.pop(context, result);
                    }
                  },
                );
              },
            );
          }
          return const Center(child: Text('Tidak ada data'));
        },
      ),
    );
  }
}
