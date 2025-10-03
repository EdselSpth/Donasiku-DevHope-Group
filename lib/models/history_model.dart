// lib/models/

// Enum untuk Status Donasi agar lebih terstruktur
enum DonationStatus { Selesai, Dikirim, Dibatalkan, Pending, InProgress }

DonationStatus _statusFromString(String status) {
  switch (status.toLowerCase()) {
    case 'completed':
      return DonationStatus.Selesai;
    case 'shipped':
      return DonationStatus.Dikirim;
    case 'cancelled':
      return DonationStatus.Dibatalkan;
    case 'pending':
      return DonationStatus.Pending;
    case 'in_progress':
      return DonationStatus.InProgress;
    default:
      return DonationStatus.Pending;
  }
}

// Model untuk setiap item di Riwayat Barang
class DonationHistoryModel {
  final String donationId;
  final String itemId;
  final String profileImageUrl;
  final String donorName;
  final String role;
  final String destination;
  final String quantity;
  final String itemName;
  final String? itemImageUrl; // Opsional, karena ada yg tidak pakai gambar
  final DonationStatus status;
  final String description;

  DonationHistoryModel({
    required this.donationId,
    required this.itemId,
    required this.profileImageUrl,
    required this.donorName,
    required this.role,
    required this.destination,
    required this.quantity,
    required this.itemName,
    this.itemImageUrl,
    required this.status,
    required this.description,
  });

  factory DonationHistoryModel.fromJson(Map<String, dynamic> json) {
    return DonationHistoryModel(
      donationId: (json['donation_id'] ?? '').toString(),
      itemId: (json['item']?['item_id'] ?? '').toString(),
      profileImageUrl:
          json['donor']?['profile_url'] ?? 'https://i.pravatar.cc/150?img=12',
      donorName: json['donor']?['name'] ?? 'Unknown Donor',
      role:
          'Donatur', // The API response doesn't seem to have this info directly on the donation
      destination: json['receiver']?['address'] ?? 'Unknown Destination',
      quantity: (json['item']?['quantity'] ?? 0).toString(),
      itemName: json['item']?['name'] ?? 'Unknown Item',
      itemImageUrl: json['item']?['image'],
      status: _statusFromString(json['status'] ?? 'pending'),
      description: json['item']?['description'] ?? '',
    );
  }
}

// Model untuk setiap item di Riwayat Chat
class ChatHistoryModel {
  final String profileImageUrl;
  final String name;
  final String lastMessage;
  final String timestamp;
  final bool isYou; // Untuk menampilkan "You: "

  ChatHistoryModel({
    required this.profileImageUrl,
    required this.name,
    required this.lastMessage,
    required this.timestamp,
    this.isYou = false,
  });
}

class ChatMessage {
  final String text;
  final String timestamp;
  final bool isMe; // true jika pesan dari kita, false jika dari lawan bicara

  ChatMessage({
    required this.text,
    required this.timestamp,
    required this.isMe,
  });
}
