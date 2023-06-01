import 'package:auth_flutter_express/api/api_chat_detail.dart';
import 'package:auth_flutter_express/models/chat_detail_model.dart';
import 'package:auth_flutter_express/socket/socket_methods.dart';
import 'package:auth_flutter_express/utils/constans.dart';
import 'package:flutter/material.dart';

class ChatDetailProvider extends ChangeNotifier {
  bool _isConnect = true;
  bool _isErrorData = false;
  bool _mainLoading = true;
  bool sendMessageLoading = false;

  bool get isConnect => _isConnect;
  bool get isErrorData => _isErrorData;
  bool get mainLoading => _mainLoading;

  final SocketMethods _socketMethods = SocketMethods();

  List<ChatDetailItemModel> _items = [];

  List<ChatDetailItemModel> get items => _items;

  Future<void> getChatDetail({required int id}) async {
    _mainLoading = true;
    notifyListeners();
    try {
      if (!await checkInternetConnection()) throw AllExceptionsApi.network;
      List<ChatDetailItemModel> chats = await ApiChatDetail().getChatDetail(id: id);
      _items = chats;
      _isConnect = true;
      _isErrorData = false;
      sendMessageLoading = false;
    } on AllExceptionsApi catch (e) {
      switch (e) {
        case AllExceptionsApi.network:
          debugPrint("Internet Error");
          _isConnect = false;
          _isErrorData = false;
          _mainLoading = false;
          notifyListeners();
          throw "";
        case AllExceptionsApi.data:
          debugPrint("Data Error");
          _isConnect = true;
          _isErrorData = true;
          _mainLoading = false;
          notifyListeners();
          throw "";
      }
    } catch (e) {
      debugPrint(e.toString());
      _mainLoading = false;
      _isConnect = true;
      _isErrorData = true;
      notifyListeners();
      throw e;
    }
    _mainLoading = false;
    notifyListeners();
  }

  Future<void> sendMessage(
      {required int chatId,
      required String newMsg,
      required int userId}) async {
    try {
      if(sendMessageLoading) return;
      sendMessageLoading = true;
      notifyListeners();
      if (!await checkInternetConnection()) throw "Нет интернет соединения";
      _socketMethods.sendMessage(chatId: chatId, msg: newMsg, userId: userId);

      sendMessageLoading = false;
      notifyListeners();
    } catch (e) {
      sendMessageLoading = false;
      notifyListeners();
      throw "Не удалось отправить сообщение";
    }
  }

  void addNewMessage({required ChatDetailItemModel newMsg}) {
    _items.add(newMsg);
    notifyListeners();
  }

  void removeMessage(id) {
    _items = _items.where((el) => el.id != id).toList();
    notifyListeners();
  }
}
