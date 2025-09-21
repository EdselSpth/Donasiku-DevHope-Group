// lib/models/

// Enum untuk Status Donasi agar lebih terstruktur
enum DonationStatus { Selesai, Dikirim, Dibatalkan }

// Model untuk setiap item di Riwayat Barang
class DonationHistoryModel {
  final String profileImageUrl;
  final String donorName;
  final String role;
  final String destination;
  final String quantity;
  final String itemName;
  final String? itemImageUrl; // Opsional, karena ada yg tidak pakai gambar
  final DonationStatus status;

  DonationHistoryModel({
    required this.profileImageUrl,
    required this.donorName,
    required this.role,
    required this.destination,
    required this.quantity,
    required this.itemName,
    this.itemImageUrl,
    required this.status,
  });
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
