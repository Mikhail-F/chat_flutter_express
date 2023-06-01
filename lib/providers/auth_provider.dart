import 'package:auth_flutter_express/api/api_auth.dart';
import 'package:auth_flutter_express/providers/profile_provider.dart';
import 'package:auth_flutter_express/screens/chatList/chat_list_page.dart';
import 'package:auth_flutter_express/utils/constans.dart';
import 'package:auth_flutter_express/utils/secure_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class AuthProvider extends ChangeNotifier {
  bool loadingLogin = false;
  bool loadingRegistration = false;

  Future<void> registrationUser(
      {required String login, required String password}) async {
    try {
      await ApiAuth().registrationUser(login: login, password: password);
    } catch (e) {
      throw e;
    }
  }

  Future<void> getTokenUserUser(
      {required String login, required String password}) async {
    try {
      String token = await ApiAuth().loginUser(login: login, password: password);
      await SecureStorage.saveAccessToken(token: token);
    } catch (e) {
      throw "Пользователь не найден";
    }
  }

  void signInUser(
      {required BuildContext context,
      required String login,
      required String password,
      required String name}) async {
    ProfileProvider profileRead = context.read<ProfileProvider>();
    AuthProvider authRead = context.read<AuthProvider>();

    try {
      loadingRegistration = true;
      notifyListeners();
      await authRead.registrationUser(login: login, password: password);
      await authRead.getTokenUserUser(login: login, password: password);

      await profileRead.createProfile(name: name);

      await profileRead.getProfile();
      Navigator.pushAndRemoveUntil(
          context,
          CupertinoPageRoute(builder: (context) => const ChatListPage()),
          (_) => false);
    } catch (e) {
      showMessege(context: context, error: e);
    }
    loadingRegistration = false;
    notifyListeners();
  }

  void logInUser(
      {required BuildContext context,
      required String login,
      required String password}) async {
    ProfileProvider profileRead = context.read<ProfileProvider>();
    AuthProvider authRead = context.read<AuthProvider>();

    try {
      loadingLogin = true;
      notifyListeners();
      await authRead.getTokenUserUser(login: login, password: password);
      await profileRead.getProfile();
      Navigator.pushAndRemoveUntil(
          context,
          CupertinoPageRoute(builder: (context) => const ChatListPage()),
          (_) => false);
    } catch (e) {
      showMessege(context: context, error: e);
    }
    loadingLogin = false;
    notifyListeners();
  }
}
