import 'package:auth_flutter_express/screens/auth/auth_login_page.dart';
import 'package:auth_flutter_express/screens/auth/auth_register_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Здарова",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => AuthRegisterPage()));
                },
                child: const Text("Регистрация"),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => AuthLoginPage()));
                },
                child: const Text("Войти"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
