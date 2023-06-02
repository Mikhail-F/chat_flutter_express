import 'dart:convert';

import 'package:auth_flutter_express/api/configure_api.dart';
import 'package:auth_flutter_express/models/chat_detail_model.dart';
import 'package:auth_flutter_express/utils/constans.dart';

class ApiChatDetail extends ConfigureApi {
  Future<List<ChatDetailItemModel>> getChatDetail({required int id}) async {
    try {
      final data = {"id": id};
      final response =
          await dio().get('/allChats/chatDetail', queryParameters: data);
      var items = jsonDecode(response.data);
      // print(items);
      return List.of(items)
          .map((el) => ChatDetailItemModel.fromMap(el))
          .toList();
    } catch (e) {
      print(e);
      throw AllExceptionsApi.data;
    }
  }
}
