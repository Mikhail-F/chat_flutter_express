import 'package:auth_flutter_express/models/chat_list_model.dart';
import 'package:auth_flutter_express/providers/allChatsProvider/all_chats_provider.dart';
import 'package:auth_flutter_express/providers/main_provider.dart';
import 'package:auth_flutter_express/screens/auth/auth_page.dart';
import 'package:auth_flutter_express/screens/chatList/components/chat_item.dart';
import 'package:auth_flutter_express/screens/createChat/create_chat_page.dart';
import 'package:auth_flutter_express/socket/socket_methods.dart';
import 'package:auth_flutter_express/utils/secure_storage.dart';
import 'package:auth_flutter_express/widgets/error_loading_page.dart';
import 'package:auth_flutter_express/widgets/no_internet_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({super.key});

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  final SocketMethods socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      AllChatsProvider chatRead = context.read<AllChatsProvider>();
      chatRead.getAllChats();
      socketMethods.allChatsListener(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    AllChatsProvider chatWatch = context.watch<AllChatsProvider>();
    AllChatsProvider chatRead = context.watch<AllChatsProvider>();
    var mainRead = context.read<MainProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Чаты"),
        centerTitle: true,
        leading: ElevatedButton(
            onPressed: () {
              SecureStorage.clearAccessToken();
              Navigator.pushAndRemoveUntil(
                  context,
                  CupertinoPageRoute(builder: (context) => AuthPage()),
                  (route) => false);
            },
            child: const Text("Выйти")),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => const CreateChatPage()));
              },
              child: const Text("Создать")),
          ElevatedButton(
              onPressed: () {
                mainRead.changeTheme();
              },
              child: const Text("СТ"))
        ],
      ),
      body: chatWatch.mainLoading
          ? const SafeArea(child: Center(child: CircularProgressIndicator()))
          : !chatWatch.isConnect
              ? NoInternetPage(reloadPage: chatRead.getAllChats)
              : chatWatch.isErrorData
                  ? ErrorLoadingPage(reloadPage: chatRead.getAllChats)
                  : _body(),
    );
  }

  Widget _body() {
    AllChatsProvider chatWatch = context.watch<AllChatsProvider>();

    return chatWatch.allChats.isNotEmpty
        ? ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: chatWatch.allChats.length,
            itemBuilder: (context, index) {
              ChatListItemModel item = chatWatch.allChats[index];
              return ChatItem(item: item);
            },
          )
        : const Center(
            child: Text("Пока нет чатов"),
          );
  }
}
