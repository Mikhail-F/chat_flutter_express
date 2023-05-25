class ChatListItemModel {
  final int id;
  final String title;

  ChatListItemModel({
    required this.id,
    required this.title,
  });

  factory ChatListItemModel.fromMap(Map<String, dynamic> map) {
    return ChatListItemModel(
      id: map['id'] ?? 0,
      title: map['name'] ?? "",
    );
  }
}
