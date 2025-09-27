
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class UserService {
  final String baseUrl = "http://10.0.2.2:3000"; // Use 10.0.2.2 for Android emulator
  final storage = new FlutterSecureStorage();

  Future<Map<String, dynamic>> getProfile() async {
    String? token = await storage.read(key: 'accessToken');
    if (token == null) {
      throw Exception('Access token not found');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/user/profile'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get profile: ${response.body}');
    }
  }
}
