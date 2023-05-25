class ChatDetailModel {
  final int id;
  final String userName;
  final List<ChatDetailItemModel> messages;

  ChatDetailModel({
    required this.id,
    required this.userName,
    required this.messages,
  });

  factory ChatDetailModel.fromMap(Map<String, dynamic> map) {
    return ChatDetailModel(
      id: map['id'] ?? 0,
      userName: map['userName'] ?? "",
      messages: List.of(map["messages"] ?? [])
          .map((el) => ChatDetailItemModel.fromMap(el))
          .toList(),
    );
  }
}

class ChatDetailItemModel {
  final int id;
  final int userId;
  final String message;

  ChatDetailItemModel({
    required this.id,
    required this.userId,
    required this.message,
  });

  factory ChatDetailItemModel.fromMap(Map<String, dynamic> map) {
    return ChatDetailItemModel(
      id: map['id'] ?? 0,
      userId: map['myId'] ?? 0,
      message: map['text'] ?? "",
    );
  }
}
