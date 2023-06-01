import 'package:auth_flutter_express/models/chat_detail_model.dart';

class ChatListItemModel {
  final int id;
  final String title;
  ChatDetailItemModel lastMessage;

  ChatListItemModel({
    required this.id,
    required this.title,
    required this.lastMessage,
  });

  factory ChatListItemModel.fromMap(Map<String, dynamic> map) {
    return ChatListItemModel(
      id: map['id'] ?? 0,
      title: map['name'] ?? "",
      lastMessage: ChatDetailItemModel.fromMap(map['lastMessage'] ?? {}),
    );
  }
}
