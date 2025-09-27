// lib/services/location_api_service.dart
import 'package:donasiku/models/login_token.dart';
import 'package:http/http.dart' as http;
import 'package:donasiku/models/location_model.dart';

class LoginServices {
  final String _baseUrl = 'http://localhost:3000';

  Future<LoginToken> login() async {
    final response = await http.get(Uri.parse('$_baseUrl/auth/login'));
    if (response.statusCode == 200) {
      final data = response.body;
      return LoginToken(
        accessToken: 'dummy_access_token',
        refreshToken: 'dummy_refresh_token',
      );
    } else {
      throw Exception('Gagal Login');
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
