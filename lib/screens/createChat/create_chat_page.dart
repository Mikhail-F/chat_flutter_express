import 'package:auth_flutter_express/models/user_profile_model.dart';
import 'package:auth_flutter_express/providers/allChatsProvider/all_users_create_chat.dart';
import 'package:auth_flutter_express/screens/createChat/components/user_item.dart';
import 'package:auth_flutter_express/socket/socket_methods.dart';
import 'package:auth_flutter_express/utils/constans.dart';
import 'package:auth_flutter_express/widgets/error_loading_page.dart';
import 'package:auth_flutter_express/widgets/no_internet_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateChatPage extends StatefulWidget {
  const CreateChatPage({super.key});

  @override
  State<CreateChatPage> createState() => _CreateChatPageState();
}

class _CreateChatPageState extends State<CreateChatPage> {
  final SocketMethods socketMethods = SocketMethods();
  final TextEditingController _chatNameConroller = TextEditingController();

  @override
  void initState() {
    AllUsersCreateChatProvider createChatRead =
        context.read<AllUsersCreateChatProvider>();
    createChatRead.getAllUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AllUsersCreateChatProvider createChatRead =
        context.read<AllUsersCreateChatProvider>();
    AllUsersCreateChatProvider createChatWatch =
        context.watch<AllUsersCreateChatProvider>();

    return Scaffold(
      appBar: AppBar(title: Text("Создать чат")),
      body: createChatWatch.mainLoading
          ? const SafeArea(child: Center(child: CircularProgressIndicator()))
          : !createChatWatch.isConnect
              ? NoInternetPage(reloadPage: createChatRead.getAllUsers)
              : createChatWatch.isErrorData
                  ? ErrorLoadingPage(reloadPage: createChatRead.getAllUsers)
                  : _body(),
    );
  }

  Widget _body() {
    AllUsersCreateChatProvider createChatRead =
        context.read<AllUsersCreateChatProvider>();
    AllUsersCreateChatProvider createChatWatch =
        context.watch<AllUsersCreateChatProvider>();

    void createChat(int id) async {
      if (_chatNameConroller.text.trim().isEmpty) return;

      try {
        await createChatRead.createChat(
            anyId: id, title: _chatNameConroller.text);
        socketMethods.addNewChat();
        Navigator.pop(context);
      } catch (e) {
        showMessege(context: context, error: e);
      }
    }

    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 40,
            child: TextField(
              controller: _chatNameConroller,
              decoration: const InputDecoration(hintText: "Название чата"),
            ),
          ),
          const SizedBox(height: 20),
          const Text("Пользователи:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: createChatWatch.allUsers.length,
              itemBuilder: (context, index) {
                UserProfileModel item = createChatWatch.allUsers[index];
                return UserItem(item: item, onPress: createChat);
              },
            ),
          ),
        ],
      ),
    );
  }
}
