import 'dart:convert';

import 'package:auth_flutter_express/api/configure_api.dart';
import 'package:auth_flutter_express/models/chat_detail_model.dart';
import 'package:auth_flutter_express/models/chat_list_model.dart';
import 'package:auth_flutter_express/models/user_profile_model.dart';
import 'package:auth_flutter_express/utils/constans.dart';

class Api extends ConfigureApi {
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

  Future<void> createProfile({required String name}) async {
    try {
      final data = {"name": name};
      await dio.post('/profile', data: data);
    } catch (e) {
      print(e);
    }
  }

  Future<UserProfileModel> getProfile() async {
    try {
      final response = await dio.get('/profile');
      var items = jsonDecode(response.data);
      // print(items);
      return UserProfileModel.fromMap(items);
    } catch (e) {
      print(e);
      throw "";
    }
  }

  Future<List<UserProfileModel>> getAllUsers() async {
    try {
      final response = await dio.get('/profile/allUsers');
      var items = jsonDecode(response.data);
      // print(items);
      return List.of(items).map((el) => UserProfileModel.fromMap(el)).toList();
    } catch (e) {
      print(e);
      throw AllExceptionsApi.data;
    }
  }

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
      print(e);
      throw "Ошибка создания чата";
    }
  }

  Future<List<ChatDetailItemModel>> getChatDetail({required int id}) async {
    try {
      final data = {"id": id};
      final response =
          await dio.get('/allChats/chatDetail', queryParameters: data);
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
