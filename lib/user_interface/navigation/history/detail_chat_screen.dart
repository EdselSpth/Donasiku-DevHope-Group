// lib/user_interface/navigation/detail_chat_screen.dart

import 'package:flutter/material.dart';
import 'package:donasiku/models/history_model.dart';
import 'package:donasiku/widget/chat_message_bubble.dart';

class DetailChatScreen extends StatefulWidget {
  // Menerima data dari halaman sebelumnya
  final ChatHistoryModel chatInfo;

  const DetailChatScreen({super.key, required this.chatInfo});

  @override
  State<DetailChatScreen> createState() => _DetailChatScreenState();
}

class _DetailChatScreenState extends State<DetailChatScreen> {
  final TextEditingController _messageController = TextEditingController();

  // Dummy data untuk percakapan
  final List<ChatMessage> messages = [
    ChatMessage(text: 'Hi zuna 🤝', timestamp: '11:31 AM', isMe: true),
    ChatMessage(
      text: 'apakah barangnya ada?',
      timestamp: '11:31 AM',
      isMe: true,
    ),
    ChatMessage(text: 'tentu ada', timestamp: '11:35 AM', isMe: false),
    ChatMessage(text: 'saya cek ulang ya', timestamp: '11:31 AM', isMe: false),
    ChatMessage(text: 'baik, terima kasih', timestamp: '11:31 AM', isMe: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        leading: const BackButton(color: Colors.black),
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(widget.chatInfo.profileImageUrl),
            ),
            const SizedBox(width: 12),
            Text(
              widget.chatInfo.name,
              style: const TextStyle(color: Colors.black, fontSize: 18),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Bagian daftar pesan
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              reverse: false, // Menampilkan dari atas ke bawah
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ChatMessageBubble(message: messages[index]);
              },
            ),
          ),
          // Bagian input pesan
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      color: Colors.white,
      child: SafeArea(
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.emoji_emotions_outlined),
              onPressed: () {},
              color: Colors.grey,
            ),
            Expanded(
              child: TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  hintText: 'Tulis pesan anda',
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Colors.grey[100],
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {},
              color: Colors.grey,
            ),
            IconButton(
              icon: const Icon(Icons.send, color: Color(0xFF0D2C63)),
              onPressed: () {
                // Logika untuk mengirim pesan
                if (_messageController.text.isNotEmpty) {
                  // Tambahkan pesan ke list (untuk demo)
                  setState(() {
                    messages.add(
                      ChatMessage(
                        text: _messageController.text,
                        timestamp: "11:36 AM", // contoh
                        isMe: true,
                      ),
                    );
                  });
                  _messageController.clear(); // Kosongkan input
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}
