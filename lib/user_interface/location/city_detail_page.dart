// lib/user_interface/location/city_detail_page.dart
import 'package:donasiku/models/location_model.dart';
import 'package:donasiku/services/location/location_api_services.dart';
import 'package:flutter/material.dart';

class CityDetailPage extends StatefulWidget {
  final Location city;
  const CityDetailPage({super.key, required this.city});

  @override
  State<CityDetailPage> createState() => _CityDetailPageState();
}

class _CityDetailPageState extends State<CityDetailPage> {
  final LocationApiService _apiService = LocationApiService();
  late Future<List<Location>> _subDistrictsFuture;

  @override
  void initState() {
    super.initState();
    _subDistrictsFuture = _apiService.getSubDistricts(widget.city.code);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.city.name)),
      body: FutureBuilder<List<Location>>(
        future: _subDistrictsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final subDistrict = snapshot.data![index];
                return ListTile(
                  title: Text(subDistrict.name),
                  onTap: () {
                    final result = '${subDistrict.name}, ${widget.city.name}';
                    // Kembali 2x untuk menutup halaman kota dan provinsi
                    int popCount = 0;
                    Navigator.of(context).popUntil((_) => popCount++ >= 2);
                    // Kirim data ke halaman form
                    Navigator.pop(context, result);
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
