import 'dart:convert';
import 'package:donasiku/models/donation_item.dart';
import 'package:donasiku/models/history_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/foundation.dart';

class DonationService {
  final String baseUrl = "http://10.0.2.2:3000";
  final storage = new FlutterSecureStorage();

  Future<List<DonationItem>> getDonationItems() async {
    String? token = await storage.read(key: 'accessToken');

    if (token == null) {
      throw Exception('User not logged in. Token is null.');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/donate/items'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> itemsJson = data['items'];

      return itemsJson.map((json) => DonationItem.fromJson(json)).toList();
    } else {
      if (kDebugMode) {
        print('Failed to load donation items.');
        print('Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
      throw Exception('Failed to load donation items');
    }
  }

  Future<DonationItem> getDonationItemById(String id) async {
    String? token = await storage.read(key: 'accessToken');

    if (token == null) {
      throw Exception('User not logged in. Token is null.');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/donate/items/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return DonationItem.fromJson(data['data']);
    } else {
      if (kDebugMode) {
        print('Failed to load donation item.');
        print('Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
      throw Exception('Failed to load donation item');
    }
  }

  Future<List<DonationHistoryModel>> getActiveDonations() async {
    String? token = await storage.read(key: 'accessToken');

    if (token == null) {
      throw Exception('User not logged in. Token is null.');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/donate/users/active'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> donationsJson = data['data'];
      return donationsJson
          .map((json) => DonationHistoryModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load active donations');
    }
  }

  Future<bool> updateDonationStatus(String donationId, String status) async {
    String? token = await storage.read(key: 'accessToken');

    if (token == null) {
      throw Exception('User not logged in. Token is null.');
    }

    final response = await http.patch(
      Uri.parse('$baseUrl/donate/$donationId/status'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({'status': status}),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      if (kDebugMode) {
        print('Failed to update donation status.');
        print('Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
      throw Exception('Failed to update donation status');
    }
  }
}
