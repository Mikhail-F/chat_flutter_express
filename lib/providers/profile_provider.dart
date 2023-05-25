import 'package:auth_flutter_express/api/api.dart';
import 'package:auth_flutter_express/models/user_profile_model.dart';
import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  late UserProfileModel user;

  Future<void> createProfile({required String name}) async {
    try {
      await Api().createProfile(name: name);
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> getProfile() async {
    try {
      UserProfileModel profile = await Api().getProfile();
      user = profile;
    } catch (e) {
      print(e);
      throw e;
    }
    notifyListeners();
  }
}
