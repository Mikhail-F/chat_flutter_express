import 'package:auth_flutter_express/models/chat_list_model.dart';
import 'package:auth_flutter_express/screens/chatDetail/chat_detail_page.dart';
import 'package:auth_flutter_express/utils/constans.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatItem extends StatelessWidget {
  final ChatListItemModel item;
  const ChatItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => ChatDetailPage(
              chatId: item.id,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        color: getThemeData(context).button,
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.title,
              style: TextStyle(
                  color: getThemeData(context).buttonText, fontSize: 16),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  item.lastMessage.message,
                  style: TextStyle(color: getThemeData(context).buttonText),
                ),
                Text(
                  item.lastMessage.time,
                  style: TextStyle(
                      color: getThemeData(context).buttonText, fontSize: 11),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
