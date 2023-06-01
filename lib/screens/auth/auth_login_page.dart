import 'package:auth_flutter_express/providers/auth_provider.dart';
import 'package:auth_flutter_express/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthLoginPage extends StatelessWidget {
  AuthLoginPage({super.key});
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void login(BuildContext context) async {
    if (_loginController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty) return;

    AuthProvider authRead = context.read<AuthProvider>();

    authRead.logInUser(
        context: context,
        login: _loginController.text,
        password: _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authWatch = context.watch<AuthProvider>();

    return Scaffold(
      appBar: AppBar(title: Text("Авторизация")),
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
              const SizedBox(height: 15),
              CustomButton(
                context: context,
                onPress: () => login(context),
                title: "Войти",
                disabled: authWatch.loadingLogin,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
