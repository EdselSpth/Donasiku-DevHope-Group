// lib/user_interface/location/province_detail_page.dart
import 'package:donasiku/models/location_model.dart';
import 'package:donasiku/services/location/location_api_services.dart';
import 'package:flutter/material.dart';
import 'city_detail_page.dart';

class ProvinceDetailPage extends StatefulWidget {
  final Location province;
  const ProvinceDetailPage({super.key, required this.province});

  @override
  State<ProvinceDetailPage> createState() => _ProvinceDetailPageState();
}

class _ProvinceDetailPageState extends State<ProvinceDetailPage> {
  final LocationApiService _apiService = LocationApiService();
  late Future<List<Location>> _citiesFuture;

  @override
  void initState() {
    super.initState();
    _citiesFuture = _apiService.getCities(widget.province.code);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.province.name)),
      body: FutureBuilder<List<Location>>(
        future: _citiesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final city = snapshot.data![index];
                return ListTile(
                  title: Text(city.name),
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CityDetailPage(city: city),
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
