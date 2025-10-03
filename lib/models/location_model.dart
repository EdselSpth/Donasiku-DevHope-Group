import 'dart:convert';

class Location {
  final int id;
  final String name;

  Location({required this.id, required this.name});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['area_id'] as int,
      name: json['area_name'] as String,
    );
  }
}

List<Location> parseAreas(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Location>((json) => Location.fromJson(json)).toList();
}
