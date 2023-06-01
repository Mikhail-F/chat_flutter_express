import 'package:auth_flutter_express/api/api_chat_list.dart';
import 'package:auth_flutter_express/models/chat_detail_model.dart';
import 'package:auth_flutter_express/models/chat_list_model.dart';
import 'package:auth_flutter_express/utils/constans.dart';
import 'package:flutter/material.dart';

class AllChatsProvider extends ChangeNotifier {
  bool _isConnect = true;
  bool _isErrorData = false;
  bool _mainLoading = true;

  bool get isConnect => _isConnect;
  bool get isErrorData => _isErrorData;
  bool get mainLoading => _mainLoading;

  List<ChatListItemModel> _allChats = [];

  List<ChatListItemModel> get allChats => _allChats;

  Future<void> getAllChats() async {
    if (!_mainLoading) {
      _mainLoading = true;
      notifyListeners();
    }
    try {
      if (!await checkInternetConnection()) throw AllExceptionsApi.network;
      List<ChatListItemModel> chats = await ApiChatList().getAllChats();
      _allChats = chats;
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

  void updateCurrentChat({required int id, required ChatDetailItemModel msg}) {
    _allChats.map((el) {
      if (el.id == id) el.lastMessage = msg;
      return el;
    }).toList();
    notifyListeners();
  }
}
