import 'package:auth_flutter_express/models/chat_list_model.dart';
import 'package:auth_flutter_express/screens/chatDetail/chat_detail_page.dart';
import 'package:auth_flutter_express/utils/constans.dart';
import 'package:auth_flutter_express/utils/custom_theme.dart';
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
              id: item.id,
            ),
          ),
        );
      },
      child: Ink(
        color: getThemeData(context).button,
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(
          item.title,
          style: TextStyle(color: getThemeData(context).buttonText),
        ),
      ),
    );
  }
}
