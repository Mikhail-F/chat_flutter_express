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
  final TextEditingController messageController = TextEditingController();
  ChatDetailItemModel? editedMsg;

  List<ChatDetailItemModel> _items = [];

  List<ChatDetailItemModel> get items => _items;

  Future<void> getChatDetail({required int id}) async {
    _mainLoading = true;
    notifyListeners();
    try {
      if (!await checkInternetConnection()) throw AllExceptionsApi.network;
      List<ChatDetailItemModel> chats =
          await ApiChatDetail().getChatDetail(id: id);
      _items = chats;
      _isConnect = true;
      _isErrorData = false;
      sendMessageLoading = false;
      messageController.clear();
      editedMsg = null;
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

  Future<void> sendMessage({required int chatId, required int userId}) async {
    try {
      if (sendMessageLoading) return;
      sendMessageLoading = true;
      notifyListeners();
      if (!await checkInternetConnection()) throw "Нет интернет соединения";
      _socketMethods.sendMessage(
          chatId: chatId, msg: messageController.text, userId: userId);
      messageController.clear();
      sendMessageLoading = false;
      notifyListeners();
    } catch (e) {
      sendMessageLoading = false;
      notifyListeners();
      throw "Не удалось отправить сообщение";
    }
  }

  Future<void> sendEditedMessage({required int chatId}) async {
    try {
      if (sendMessageLoading) return;
      sendMessageLoading = true;
      notifyListeners();
      if (!await checkInternetConnection()) throw "Нет интернет соединения";
      _socketMethods.editMessage(
          chatId: chatId, newText: messageController.text, id: editedMsg!.id);
      editedMsg = null;
      messageController.clear();
      sendMessageLoading = false;
      notifyListeners();
    } catch (e) {
      sendMessageLoading = false;
      notifyListeners();
      throw "Не удалось изменить сообщение";
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

  void editMessage(int id, String msg) {
    _items.map((el) {
      if (el.id == id) {
        el.message = msg;
      }
      return el;
    }).toList();
    notifyListeners();
  }

  void selectEditedMsg(ChatDetailItemModel? msg) {
    editedMsg = msg;
    if (msg != null)
      messageController.text = editedMsg!.message;
    else
      messageController.clear();
    notifyListeners();
  }
}
