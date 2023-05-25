import 'package:auth_flutter_express/api/api.dart';
import 'package:auth_flutter_express/utils/secure_storage.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  Future<void> registrationUser(
      {required String login, required String password}) async {
    try {
      await Api().registrationUser(login: login, password: password);
    } catch (e) {
      throw e;
    }
  }

  Future<void> loginUser(
      {required String login, required String password}) async {
    try {
      String token = await Api().loginUser(login: login, password: password);
      await SecureStorage.saveAccessToken(token: token);
    } catch (e) {
      throw "Пользователь не найден";
    }
    notifyListeners();
  }
}
