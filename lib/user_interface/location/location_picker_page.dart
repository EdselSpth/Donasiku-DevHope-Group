// lib/user_interface/location/location_picker_page.dart
import 'package:donasiku/models/location_model.dart';
import 'package:donasiku/services/location/location_api_services.dart';
import 'package:flutter/material.dart';

class LocationPickerPage extends StatefulWidget {
  const LocationPickerPage({super.key});
  @override
  State<LocationPickerPage> createState() => _LocationPickerPageState();
}

class _LocationPickerPageState extends State<LocationPickerPage> {
  final LocationApiService _apiService = LocationApiService();
  late Future<List<Location>> _areasFuture;

  @override
  void initState() {
    super.initState();
    _areasFuture = _apiService.getAreas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pilih Area')),
      body: FutureBuilder<List<Location>>(
        future: _areasFuture,
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
                final area = snapshot.data![index];
                return ListTile(
                  title: Text(area.name),
                  onTap: () {
                    Navigator.pop(context, area);
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
