import 'package:auth_flutter_express/models/chat_detail_model.dart';
import 'package:auth_flutter_express/providers/chat_detail_provider.dart';
import 'package:auth_flutter_express/providers/profile_provider.dart';
import 'package:auth_flutter_express/screens/chatDetail/components/chat_edit_message.dart';
import 'package:auth_flutter_express/screens/chatDetail/components/chat_messsage.dart';
import 'package:auth_flutter_express/socket/main_socket.dart';
import 'package:auth_flutter_express/socket/socket_methods.dart';
import 'package:auth_flutter_express/widgets/error_loading_page.dart';
import 'package:auth_flutter_express/widgets/no_internet_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class ChatDetailPage extends StatefulWidget {
  final int chatId;
  const ChatDetailPage({super.key, required this.chatId});

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final ScrollController _scrollListController = ScrollController();

  final MainSocket socket = MainSocket.instance;
  final SocketMethods socketMethods = SocketMethods();
  bool textFieldIsEmpty = true;

  @override
  void initState() {
    super.initState();
    // _messageController.addListener(() {
    //   textFieldIsEmpty = _messageController.text.isEmpty;
    //   setState(() {});
    // });
    SchedulerBinding.instance.addPostFrameCallback((_) {
      socketMethods.sendMessageListener(context);
      ChatDetailProvider chatRead = context.read<ChatDetailProvider>();
      chatRead.getChatDetail(id: widget.chatId);
      socketMethods.chatDetailJoinOrLeave(id: widget.chatId, isJoin: true);
    });
  }

  void sendMessage() {
    ChatDetailProvider chatRead = context.read<ChatDetailProvider>();
    ProfileProvider profileRead = context.read<ProfileProvider>();
    chatRead.sendMessage(chatId: widget.chatId, userId: profileRead.user.id);
  }

  void saveEditMessage() {
    ChatDetailProvider chatRead = context.read<ChatDetailProvider>();
    chatRead.sendEditedMessage(chatId: widget.chatId);
  }

  @override
  void deactivate() {
    socketMethods.chatDetailJoinOrLeave(id: widget.chatId, isJoin: false);
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    ChatDetailProvider chatWatch = context.watch<ChatDetailProvider>();
    ChatDetailProvider chatRead = context.read<ChatDetailProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Детальный чат")),
      body: chatWatch.mainLoading
          ? const SafeArea(child: Center(child: CircularProgressIndicator()))
          : !chatWatch.isConnect
              ? NoInternetPage(
                  reloadPage: () => chatRead.getChatDetail(id: widget.chatId))
              : chatWatch.isErrorData
                  ? ErrorLoadingPage(
                      reloadPage: () =>
                          chatRead.getChatDetail(id: widget.chatId))
                  : _body(),
    );
  }

  Widget _body() {
    ChatDetailProvider chatWatch = context.watch<ChatDetailProvider>();
    ChatDetailProvider chatRead = context.read<ChatDetailProvider>();

    ProfileProvider profileRead = context.read<ProfileProvider>();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      _scrollListController
          .jumpTo(_scrollListController.position.maxScrollExtent);
    });

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollListController,
                itemCount: chatWatch.items.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  ChatDetailItemModel item = chatWatch.items[index];
                  bool isMe = profileRead.user.id == item.userId;
                  return ChatMessage(
                      item: item, chatId: widget.chatId, isMe: isMe);
                },
              ),
            ),
            if (chatWatch.editedMsg != null) const ChatEditMessage(),
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 200, minHeight: 50),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration:
                          const InputDecoration(hintText: "Сообщение..."),
                      controller: chatRead.messageController,
                      minLines: 1,
                      maxLines: 5,
                    ),
                  ),
                  // textFieldIsEmpty
                  //     ? const RecordMessage()
                  //     :
                  InkWell(
                    onTap: chatWatch.editedMsg == null
                        ? sendMessage
                        : saveEditMessage,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.lightGreen,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: chatWatch.sendMessageLoading
                          ? const CircularProgressIndicator()
                          : const Icon(
                              Icons.send,
                              color: Colors.white,
                            ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
