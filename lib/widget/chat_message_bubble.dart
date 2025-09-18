import 'package:flutter/material.dart';
import 'package:donasiku/models/history_model.dart';

class ChatMessageBubble extends StatelessWidget {
  final ChatMessage message;

  const ChatMessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    // Menentukan posisi gelembung chat (kanan untuk 'isMe', kiri untuk lainnya)
    final alignment =
        message.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final color = message.isMe ? const Color(0xFF0D2C63) : Colors.white;
    final textColor = message.isMe ? Colors.white : Colors.black87;
    final bubbleRadius =
        message.isMe
            ? const BorderRadius.only(
              topLeft: Radius.circular(16),
              bottomLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            )
            : const BorderRadius.only(
              topRight: Radius.circular(16),
              bottomRight: Radius.circular(16),
              topLeft: Radius.circular(16),
            );

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Column(
        crossAxisAlignment: alignment,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: color,
              borderRadius: bubbleRadius,
              boxShadow: [
                if (!message.isMe)
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 5,
                    offset: const Offset(1, 2),
                  ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min, // Agar bubble pas dengan konten
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Flexible(
                  child: Text(
                    message.text,
                    style: TextStyle(color: textColor, fontSize: 15),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  message.timestamp,
                  style: TextStyle(
                    color: message.isMe ? Colors.white70 : Colors.grey,
                    fontSize: 10,
                  ),
                ),
                if (message.isMe) ...[
                  const SizedBox(width: 4),
                  const Icon(Icons.done_all, color: Colors.white70, size: 16),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
