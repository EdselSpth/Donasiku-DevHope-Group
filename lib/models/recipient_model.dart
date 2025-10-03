class RecipientModel {
  final String logoUrl;
  final String name;
  final String description;
  final bool isVerified;
  final String? fullDescription;
  final String? address;
  final String? founder;
  final String? contact;
  final String? memberCount;

  RecipientModel({
    required this.logoUrl,
    required this.name,
    required this.description,
    this.isVerified = true,
    this.fullDescription,
    this.address,
    this.founder,
    this.contact,
    this.memberCount,
  });
}
