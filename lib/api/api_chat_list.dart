import 'dart:convert';

import 'package:auth_flutter_express/api/configure_api.dart';
import 'package:auth_flutter_express/models/chat_list_model.dart';
import 'package:auth_flutter_express/utils/constans.dart';
import 'package:dio/dio.dart';

class ApiChatList extends ConfigureApi {

  Future<List<ChatListItemModel>> getAllChats() async {
    try {
      final response = await dio.get('/allChats');
      var items = jsonDecode(response.data);
      print(items);
      return List.of(items).map((el) => ChatListItemModel.fromMap(el)).toList();
    } catch (e) {
      print(e);
      throw AllExceptionsApi.data;
    }
  }

   Future<void> createChat({
    required int anyId,
    required String title,
  }) async {
    try {
      final data = {"anyId": anyId, "name": title};
      await dio.post('/allChats', data: data);

      return;
    } catch (e) {
      if (e is DioError) {
        var resError = e.response!;
        var errorText = jsonDecode(e.response.toString())['errorText'];
        if (resError.statusCode == 300) throw errorText;
      }
      // print(e);
      throw "Ошибка создания чата";
    }
  }
}
