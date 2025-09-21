
import 'dart:convert';

class Location {
  final String code;
  final String name;

  Location({required this.code, required this.name});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(code: json['code'] as String, name: json['name'] as String);
  }
}

// Helper function untuk parsing list
List<Location> parseLocations(String responseBody) {
  final parsed = jsonDecode(responseBody)['data'].cast<Map<String, dynamic>>();
  return parsed.map<Location>((json) => Location.fromJson(json)).toList();
}
