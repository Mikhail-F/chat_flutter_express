import 'dart:convert';

import 'package:auth_flutter_express/api/configure_api.dart';

class ApiAuth extends ConfigureApi {
  Future<void> registrationUser(
      {required String login, required String password}) async {
    try {
      final data = {"login": login, "password": password};
      await dio.post('/auth', data: data);
    } catch (e) {
      print(e);
    }
  }

  Future<String> loginUser(
      {required String login, required String password}) async {
    final data = {"login": login, "password": password};
    try {
      final response = await dio.get('/auth', queryParameters: data);
      var items = jsonDecode(response.data);

      return items["accessToken"].toString();
    } catch (e) {
      // print(e);
      throw "";
    }
  }
}
