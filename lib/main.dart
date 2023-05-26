import 'package:auth_flutter_express/providers/allChatsProvider/all_chats_provider.dart';
import 'package:auth_flutter_express/providers/auth_provider.dart';
import 'package:auth_flutter_express/providers/chat_detail_provider.dart';
import 'package:auth_flutter_express/providers/profile_provider.dart';
import 'package:auth_flutter_express/screens/splash_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

import 'providers/allChatsProvider/all_users_create_chat.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // const FlutterSecureStorage().deleteAll();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChatDetailProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => AllChatsProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => AllUsersCreateChatProvider()),
      ],
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            FocusManager.instance.primaryFocus!.unfocus();
          }
        },
        child: MaterialApp(
          scrollBehavior: MyCustomScrollBehavior(),
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const SplashPage(),
        ),
      ),
    );
  }
}

// Нужно для работы скролла на макОС и возможно виндовс
class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

// class MainPage extends StatelessWidget {
//   MainPage({super.key});
//   final TextEditingController _loginController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(mainAxisSize: MainAxisSize.min, children: [
//           TextField(
//             controller: _loginController,
//           ),
//           TextField(
//             controller: _passwordController,
//           ),
//           ElevatedButton(
//             onPressed: () {
//               Api().registrationUser(
//                   login: _loginController.text,
//                   password: _passwordController.text);
//             },
//             child: Text("Registration"),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               Api().loginUser(
//                   login: _loginController.text,
//                   password: _passwordController.text);
//             },
//             child: Text("Login"),
//           ),
//         ]),
//       ),
//     );
//   }
// }
