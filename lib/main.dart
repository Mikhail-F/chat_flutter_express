import 'package:auth_flutter_express/providers/allChatsProvider/all_chats_provider.dart';
import 'package:auth_flutter_express/providers/auth_provider.dart';
import 'package:auth_flutter_express/providers/chat_detail_provider.dart';
import 'package:auth_flutter_express/providers/main_provider.dart';
import 'package:auth_flutter_express/providers/profile_provider.dart';
import 'package:auth_flutter_express/screens/splash_page.dart';
import 'package:auth_flutter_express/utils/custom_colors.dart';
import 'package:auth_flutter_express/utils/custom_theme.dart';
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
        ChangeNotifierProvider(create: (_) => MainProvider()),
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
        child: const MainApp(),
      ),
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    var mainWatch = context.watch<MainProvider>();

    return MaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      themeMode: mainWatch.isDarkTheme ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        scaffoldBackgroundColor: CustomColors.white,
        extensions: const [
          CustomThemeColor(
            button: CustomColors.grey,
            buttonText: CustomColors.black,
          ),
        ],
      ),
      darkTheme: ThemeData(
        scaffoldBackgroundColor: CustomColors.black,
        extensions: const [
          CustomThemeColor(
            button: CustomColors.white,
            buttonText: CustomColors.grey,
          ),
        ],
      ),
      home: const SplashPage(),
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

// import 'dart:async';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:record/record.dart';

// // import 'package:record_example/audio_player.dart';

// void main() => runApp(const MyApp());

// class AudioRecorder extends StatefulWidget {
//   final void Function(String path) onStop;

//   const AudioRecorder({Key? key, required this.onStop}) : super(key: key);

//   @override
//   State<AudioRecorder> createState() => _AudioRecorderState();
// }

// class _AudioRecorderState extends State<AudioRecorder> {
//   int _recordDuration = 0;
//   Timer? _timer;
//   final _audioRecorder = Record();
//   RecordState _recordState = RecordState.stop;

//   @override
//   void initState() {
//     _audioRecorder.onStateChanged().listen((recordState) {
//       setState(() => _recordState = recordState);
//     });

//     super.initState();
//   }

//   Future<void> _start() async {
//     try {
//       if (await _audioRecorder.hasPermission()) {
//         // We don't do anything with this but printing
//         final isSupported = await _audioRecorder.isEncoderSupported(
//           AudioEncoder.aacLc,
//         );
//         if (kDebugMode) {
//           print('${AudioEncoder.aacLc.name} supported: $isSupported');
//         }
//         await _audioRecorder.start();
//         _recordDuration = 0;

//         _startTimer();
//       }
//     } catch (e) {
//       if (kDebugMode) {
//         print(e);
//       }
//     }
//   }

//   Future<void> _stop() async {
//     _timer?.cancel();
//     _recordDuration = 0;

//     final path = await _audioRecorder.stop();

//     if (path != null) {
//       widget.onStop(path);
//     }
//   }

//   Future<void> _pause() async {
//     _timer?.cancel();
//     await _audioRecorder.pause();
//   }

//   Future<void> _resume() async {
//     _startTimer();
//     await _audioRecorder.resume();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 _buildRecordStopControl(),
//                 const SizedBox(width: 20),
//                 _buildPauseResumeControl(),
//                 const SizedBox(width: 20),
//                 _buildText(),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     _audioRecorder.dispose();
//     super.dispose();
//   }

//   Widget _buildRecordStopControl() {
//     late Icon icon;
//     late Color color;

//     if (_recordState != RecordState.stop) {
//       icon = const Icon(Icons.stop, color: Colors.red, size: 30);
//       color = Colors.red.withOpacity(0.1);
//     } else {
//       final theme = Theme.of(context);
//       icon = Icon(Icons.mic, color: theme.primaryColor, size: 30);
//       color = theme.primaryColor.withOpacity(0.1);
//     }

//     return ClipOval(
//       child: Material(
//         color: color,
//         child: InkWell(
//           child: SizedBox(width: 56, height: 56, child: icon),
//           onTap: () {
//             (_recordState != RecordState.stop) ? _stop() : _start();
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildPauseResumeControl() {
//     if (_recordState == RecordState.stop) {
//       return const SizedBox.shrink();
//     }

//     late Icon icon;
//     late Color color;

//     if (_recordState == RecordState.record) {
//       icon = const Icon(Icons.pause, color: Colors.red, size: 30);
//       color = Colors.red.withOpacity(0.1);
//     } else {
//       final theme = Theme.of(context);
//       icon = const Icon(Icons.play_arrow, color: Colors.red, size: 30);
//       color = theme.primaryColor.withOpacity(0.1);
//     }

//     return ClipOval(
//       child: Material(
//         color: color,
//         child: InkWell(
//           child: SizedBox(width: 56, height: 56, child: icon),
//           onTap: () {
//             (_recordState == RecordState.pause) ? _resume() : _pause();
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildText() {
//     if (_recordState != RecordState.stop) {
//       return _buildTimer();
//     }

//     return const Text("Waiting to record");
//   }

//   Widget _buildTimer() {
//     final String minutes = _formatNumber(_recordDuration ~/ 60);
//     final String seconds = _formatNumber(_recordDuration % 60);

//     return Text(
//       '$minutes : $seconds',
//       style: const TextStyle(color: Colors.red),
//     );
//   }

//   String _formatNumber(int number) {
//     String numberStr = number.toString();
//     if (number < 10) {
//       numberStr = '0$numberStr';
//     }

//     return numberStr;
//   }

//   void _startTimer() {
//     _timer?.cancel();

//     _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
//       setState(() => _recordDuration++);
//     });
//   }
// }

// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   bool showPlayer = false;
//   String? audioPath;

//   @override
//   void initState() {
//     showPlayer = false;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: Center(
//           child: AudioRecorder(
//             onStop: (path) {
//               if (kDebugMode) print('Recorded file path: $path');
//               setState(() {
//                 audioPath = path;
//                 showPlayer = true;
//               });
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
