import 'dart:math';

import 'package:auth_flutter_express/models/chat_detail_model.dart';
import 'package:auth_flutter_express/providers/chat_detail_provider.dart';
import 'package:auth_flutter_express/socket/socket_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class ChatMessage extends StatelessWidget {
  final ChatDetailItemModel item;
  final int chatId;
  final bool isMe;
  ChatMessage(
      {super.key,
      required this.item,
      required this.chatId,
      required this.isMe});
  final SocketMethods socketMethods = SocketMethods();

  void removeMsg(BuildContext context) {
    socketMethods.removeMessage(chatId: chatId, id: item.id);
  }

  void editMsg(BuildContext context) {
    ChatDetailProvider chatRead = context.read<ChatDetailProvider>();
    chatRead.selectEditedMsg(item);
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(Random().nextInt(1000000)),
      // startActionPane: !isMe
      //     ? ActionPane(
      //         motion: const ScrollMotion(),
      //         children: [
      //           SlidableAction(
      //             onPressed: (_) {},
      //             backgroundColor: const Color.fromARGB(255, 127, 127, 127),
      //             foregroundColor: Colors.white,
      //             icon: Icons.share,
      //             label: 'Ответить',
      //           ),
      //         ],
      //       )
      //     : null,
      endActionPane: isMe
          ? ActionPane(
              key: ValueKey(Random().nextInt(1000000)),
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: removeMsg,
                  backgroundColor: const Color(0xFFFE4A49),
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
                SlidableAction(
                  onPressed: editMsg,
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  icon: Icons.edit,
                  label: 'Edit',
                ),
              ],
            )
          : null,
      child: Padding(
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
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Flexible(
                  child: Text(
                    item.message,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: isMe ? Colors.white : Colors.black87),
                  ),
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
      ),
    );
  }
}
