import 'package:auth_flutter_express/providers/chat_detail_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatEditMessage extends StatelessWidget {
  const ChatEditMessage({super.key});

  void closeEditMessage(BuildContext context) {
    ChatDetailProvider chatRead = context.read<ChatDetailProvider>();
    chatRead.selectEditedMsg(null);
  }

  @override
  Widget build(BuildContext context) {
    ChatDetailProvider chatWatch = context.watch<ChatDetailProvider>();
    return Container(
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Редактирование",
                    style: TextStyle(
                        fontWeight: FontWeight.w500, color: Colors.blue),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    chatWatch.editedMsg!.message,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.black87),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            IconButton(
              onPressed: () => closeEditMessage(context),
              icon: const Icon(Icons.close),
            ),
          ],
        ));
  }
}
