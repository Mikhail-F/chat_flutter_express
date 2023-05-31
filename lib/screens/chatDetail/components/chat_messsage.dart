import 'package:auth_flutter_express/models/chat_detail_model.dart';
import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final ChatDetailItemModel item;
  final bool isMe;
  const ChatMessage({super.key, required this.item, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        isMe ? 64.0 : 16.0,
        4,
        isMe ? 16.0 : 64.0,
        4,
      ),
      child: Align(
        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          decoration: BoxDecoration(
            color: isMe ? Colors.blue : Colors.grey[300],
            borderRadius: BorderRadius.circular(16),
          ),
          margin: const EdgeInsets.symmetric(vertical: 7),
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                item.message,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: isMe ? Colors.white : Colors.black87),
              ),
              Transform.translate(
                offset: const Offset(0, 7),
                child: Text(
                  item.time,
                  style: const TextStyle(fontSize: 10, color: Colors.black54),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
