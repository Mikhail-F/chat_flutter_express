import 'package:auth_flutter_express/providers/auth_provider.dart';
import 'package:auth_flutter_express/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthRegisterPage extends StatelessWidget {
  AuthRegisterPage({super.key});
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  void signIn(BuildContext context) async {
    if (_loginController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty ||
        _nameController.text.trim().isEmpty) return;

    AuthProvider authRead = context.read<AuthProvider>();

    authRead.signInUser(
        context: context,
        login: _loginController.text,
        password: _passwordController.text,
        name: _nameController.text);
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authWatch = context.watch<AuthProvider>();

    return Scaffold(
      appBar: AppBar(title: Text("Регистрация")),
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
              CustomButton(
                  context: context,
                  onPress: () => signIn(context),
                  title: "Регистрация",
                  disabled: authWatch.loadingRegistration),
            ],
          ),
        ),
      ),
    );
  }
}
