import 'package:auth_flutter_express/models/chat_detail_model.dart';
import 'package:auth_flutter_express/providers/allChatsProvider/all_chats_provider.dart';
import 'package:auth_flutter_express/providers/chat_detail_provider.dart';
import 'package:auth_flutter_express/socket/main_socket.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketMethods {
  final Socket _socket = MainSocket.instance.socket!;

// Отправка на сервер
  void sendMessage(
      {required int id, required String msg, required int userId}) {
    if (msg.trim().isEmpty) return;

    _socket.emit("Send message", {"id": id, "myId": userId, "text": msg});
  }

  void addNewChat() {
    _socket.emit("Add new chat");
  }

  void chatDetailJoinOrLeave({required int id, required bool isJoin}) {
    _socket.emit("Chat detail join/leave", {"id": id, "isJoin": isJoin});
  }

// Прием с сервера
  void sendMessageListener(BuildContext context) {
    if (_socket.hasListeners("Success send message")) return;
    ChatDetailProvider chatRead = context.read<ChatDetailProvider>();

    _socket.on("Success send message", (data) {
      print("Отправка сообщения");
      chatRead.addNewMessage(newMsg: ChatDetailItemModel.fromMap(data));
    });

    _socket.on("Error send message", (_) {
      print("Eror send message");
    });
  }

  void allChatsListener(BuildContext context) {
    if (_socket.hasListeners("Update All Chats")) return;
    AllChatsProvider chatRead = context.read<AllChatsProvider>();

    _socket.on("Update all chats", (_) {
      chatRead.getAllChats();
    });
  }
}
