import 'dart:convert';

import 'package:auth_flutter_express/api/configure_api.dart';
import 'package:auth_flutter_express/models/user_profile_model.dart';
import 'package:auth_flutter_express/utils/constans.dart';

class ApiProfile extends ConfigureApi {
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
      return List.of(items).map((el) => UserProfileModel.fromMap(el)).toList();
    } catch (e) {
      print(e);
      throw AllExceptionsApi.data;
    }
  }
}
