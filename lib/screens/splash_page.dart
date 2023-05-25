import 'package:auth_flutter_express/api/configure_api.dart';
import 'package:auth_flutter_express/providers/profile_provider.dart';
import 'package:auth_flutter_express/screens/auth/auth_page.dart';
import 'package:auth_flutter_express/screens/chatList/chat_list_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  
  void loadData() async {
    await ConfigureApi.setDeviceId();
    if (ConfigureApi.token == 0) {
      Navigator.pushAndRemoveUntil(context,
          CupertinoPageRoute(builder: (_) => AuthPage()), (route) => false);
      return;
    }
    ProfileProvider profileRead = context.read<ProfileProvider>();
    await profileRead.getProfile();

    Navigator.pushAndRemoveUntil(
        context,
        CupertinoPageRoute(builder: (_) => const ChatListPage()),
        (route) => false);
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: CircularProgressIndicator(color: Colors.amber),
      ),
    );
  }
}
