// lib/widget/chat_list_item.dart

import 'package:donasiku/user_interface/navigation/history/detail_chat_screen.dart'; // 1. Import halaman detail
import 'package:flutter/material.dart';
import 'package:donasiku/models/history_model.dart';

class ChatListItem extends StatelessWidget {
  final ChatHistoryModel chatItem;

  const ChatListItem({super.key, required this.chatItem});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 28,
        backgroundImage: NetworkImage(chatItem.profileImageUrl),
      ),
      title: Text(
        chatItem.name,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text.rich(
        TextSpan(
          children: [
            if (chatItem.isYou)
              const TextSpan(
                text: "You: ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            TextSpan(text: chatItem.lastMessage),
          ],
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Text(
        chatItem.timestamp,
        style: const TextStyle(color: Colors.grey, fontSize: 12),
      ),
      onTap: () {
        // 2. Tambahkan navigasi di sini
        Navigator.push(
          context,
          MaterialPageRoute(
            // Buka DetailChatScreen dan kirim data 'chatItem'
            builder: (context) => DetailChatScreen(chatInfo: chatItem),
          ),
        );
      },
    );
  }
}
