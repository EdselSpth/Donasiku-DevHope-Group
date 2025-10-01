import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:donasiku/models/location_model.dart';

class LocationApiService {
  final String _baseUrl = 'http://10.0.2.2:3000';
  final _storage = const FlutterSecureStorage();

  Future<List<Location>> getAreas() async {
    final token = await _storage.read(key: 'accessToken');

    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/area/areas'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return parseAreas(response.body);
      } else {
        print(
            '[LocationApiService] Failed to load areas. Status code: ${response.statusCode}');
        print('[LocationApiService] Response body: ${response.body}');
        throw Exception('Gagal memuat area');
      }
    } catch (e) {
      print('[LocationApiService] Error fetching areas: $e');
      rethrow;
    }
  }
}
