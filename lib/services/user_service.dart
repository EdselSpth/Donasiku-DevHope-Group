import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserService {
  final String _baseUrl = 'http://10.0.2.2:3000';
  final _storage = const FlutterSecureStorage();

  Future<void> updateProfile({
    required String name,
    required String phone,
    required String address,
    required int areaId,
  }) async {
    final token = await _storage.read(key: 'accessToken');
    if (token == null) {
      throw Exception('Auth token not found. Please log in again.');
    }

    final uri = Uri.parse('$_baseUrl/user/profile');
    var request = http.MultipartRequest('PUT', uri);

    request.headers['Authorization'] = 'Bearer $token';

    request.fields['name'] = name;
    request.fields['phone'] = phone;
    request.fields['address'] = address;
    request.fields['area_id'] = areaId.toString();

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode != 200) {
        final responseData = json.decode(response.body);
        final errorMessage = responseData['message'] ?? 'Unknown error';
        throw Exception('Failed to update profile: $errorMessage');
      }
    } catch (e) {
      // Handle network errors or other exceptions
      throw Exception('An error occurred: $e');
    }
  }
}
