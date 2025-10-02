class DonationItem {
  final String id;
  final String imageUrl;
  final String title;
  final String location;
  final String description;
  final String owner;

  DonationItem({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.location,
    required this.description,
    required this.owner,
  });

  factory DonationItem.fromJson(Map<String, dynamic> json) {
    return DonationItem(
      id: (json['item_id'] ?? '').toString(),
      title: (json['name'] ?? '').toString(),
      location:
          json['area'] != null
              ? (json['area']['name'] ?? '').toString()
              : 'Unknown',
      imageUrl: (json['image'] ?? '').toString(),
      description: (json['description'] ?? '').toString(),
      owner:
          json['donor'] != null
              ? (json['donor']['name'] ?? '').toString()
              : 'Unknown',
    );
  }
}
