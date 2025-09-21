// lib/services/location_api_service.dart
import 'package:http/http.dart' as http;
import 'package:donasiku/models/location_model.dart';

class LocationApiService {
  final String _baseUrl = 'https://wilayah.id/api';

  Future<List<Location>> getProvinces() async {
    final response = await http.get(Uri.parse('$_baseUrl/provinces.json'));
    if (response.statusCode == 200) {
      return parseLocations(response.body);
    } else {
      throw Exception('Gagal memuat provinsi');
    }
  }

  Future<List<Location>> getCities(String provinceCode) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/regencies/$provinceCode.json'),
    );
    if (response.statusCode == 200) {
      return parseLocations(response.body);
    } else {
      throw Exception('Gagal memuat kota/kabupaten');
    }
  }

  Future<List<Location>> getSubDistricts(String cityCode) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/districts/$cityCode.json'),
    );
    if (response.statusCode == 200) {
      return parseLocations(response.body);
    } else {
      throw Exception('Gagal memuat kecamatan');
    }
  }
}
