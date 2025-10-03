import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class RequestService {
  final String baseUrl = "http://10.0.2.2:3000";
  final storage = new FlutterSecureStorage();

  Future<void> approveRequest(int requestId, int itemId) async {
    String? token = await storage.read(key: 'accessToken');

    if (token == null) {
      throw Exception('User not logged in. Token is null.');
    }

    final response = await http.patch(
      Uri.parse('$baseUrl/donate/approve'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({'request_id': requestId, 'item_id': itemId}),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to approve request');
    }
  }
}
