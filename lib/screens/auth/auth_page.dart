import 'package:auth_flutter_express/providers/auth_provider.dart';
import 'package:auth_flutter_express/providers/profile_provider.dart';
import 'package:auth_flutter_express/screens/chatList/chat_list_page.dart';
import 'package:auth_flutter_express/utils/constans.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatelessWidget {
  AuthPage({super.key});
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ProfileProvider profileRead = context.read<ProfileProvider>();
    AuthProvider authRead = context.read<AuthProvider>();

    void registration() async {
      if (_loginController.text.trim().isEmpty ||
          _passwordController.text.trim().isEmpty ||
          _nameController.text.trim().isEmpty) return;

      try {
        await authRead.registrationUser(
            login: _loginController.text, password: _passwordController.text);
        await authRead.loginUser(
            login: _loginController.text, password: _passwordController.text);

        await profileRead.createProfile(name: _nameController.text);

        await profileRead.getProfile();
        Navigator.push(context,
            CupertinoPageRoute(builder: (context) => const ChatListPage()));
      } catch (e) {
        showMessege(context: context, error: e);
      }
    }

    void login() async {
      if (_loginController.text.trim().isEmpty ||
          _passwordController.text.trim().isEmpty) return;

      try {
        await authRead.loginUser(
            login: _loginController.text, password: _passwordController.text);
        await profileRead.getProfile();
        Navigator.push(context,
            CupertinoPageRoute(builder: (context) => const ChatListPage()));
      } catch (e) {
        showMessege(context: context, error: e);
      }
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(hintText: "Логин"),
                controller: _loginController,
              ),
              TextField(
                decoration: const InputDecoration(hintText: "Пароль"),
                controller: _passwordController,
              ),
              TextField(
                decoration: const InputDecoration(hintText: "Никнейм"),
                controller: _nameController,
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: registration,
                child: const Text("Регистрация"),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: login,
                child: const Text("Войти"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
