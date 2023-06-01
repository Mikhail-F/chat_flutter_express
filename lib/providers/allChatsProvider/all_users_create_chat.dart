import 'package:auth_flutter_express/api/api_profile.dart';
import 'package:auth_flutter_express/api/api_chat_list.dart';
import 'package:auth_flutter_express/models/user_profile_model.dart';
import 'package:auth_flutter_express/utils/constans.dart';
import 'package:flutter/material.dart';

class AllUsersCreateChatProvider extends ChangeNotifier {
  bool _isConnect = true;
  bool _isErrorData = false;
  bool _mainLoading = true;

  bool get isConnect => _isConnect;
  bool get isErrorData => _isErrorData;
  bool get mainLoading => _mainLoading;

  List<UserProfileModel> _allUsers = [];

  List<UserProfileModel> get allUsers => _allUsers;

  Future<void> getAllUsers() async {
    _mainLoading = true;
    notifyListeners();
    try {
      if (!await checkInternetConnection()) throw AllExceptionsApi.network;
      List<UserProfileModel> response = await ApiProfile().getAllUsers();
      _allUsers = response;
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

  Future<void> createChat({
    required int anyId,
    required String title,
  }) async {
    try {
      if (!await checkInternetConnection()) throw AllExceptionsApi.network;
      await ApiChatList().createChat(anyId: anyId, title: title);
    } catch (e) {
      print(e);
      throw e;
    }
    notifyListeners();
  }
}
