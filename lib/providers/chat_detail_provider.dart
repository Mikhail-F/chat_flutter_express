import 'package:auth_flutter_express/api/api.dart';
import 'package:auth_flutter_express/models/chat_detail_model.dart';
import 'package:auth_flutter_express/socket/socket_methods.dart';
import 'package:auth_flutter_express/utils/constans.dart';
import 'package:flutter/material.dart';

class ChatDetailProvider extends ChangeNotifier {
  bool _isConnect = true;
  bool _isErrorData = false;
  bool _mainLoading = true;

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
      List<ChatDetailItemModel> chats = await Api().getChatDetail(id: id);
      _items = chats;
      _isConnect = true;
      _isErrorData = false;
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
      {required int id, required String newMsg, required int userId}) async {
    try {
      if (!await checkInternetConnection()) throw "Нет интернет соединения";
      _socketMethods.sendMessage(id: id, msg: newMsg, userId: userId);
    } catch (e) {
      throw "Не удалось отправить сообщение";
    }
  }

  void addNewMessage({required ChatDetailItemModel newMsg}) {
    _items.add(newMsg);
    notifyListeners();
  }
}
