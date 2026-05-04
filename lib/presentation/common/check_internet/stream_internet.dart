import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class StreamInternet {
  StreamInternet._init();
  static final StreamInternet _instance = StreamInternet._init();
  static StreamInternet get instance => _instance;

  Stream<String> get messageStream => _messageController.stream;
  final _messageController = StreamController<String>.broadcast();

  Future<List<ConnectivityResult>> get checkConnect =>
      Connectivity().checkConnectivity();

  // Future<bool> checkVpnConnect() async {
  //   return (await StreamInternet.instance.checkConnect)
  //       .contains(ConnectivityResult.vpn);
  // }

  listen() {
    Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      // if (result.contains(ConnectivityResult.vpn)) {
      //   _messageController.add(vpnConnected);
      // } else
      if (result.contains(ConnectivityResult.wifi) ||
          result.contains(ConnectivityResult.mobile)) {
        // _messageController.add(internetConnected);
      } else if (result.contains(ConnectivityResult.none)) {
        // _messageController.add(internetDisconnected);
      }
    });
  }

  static const String internetConnected = "internetConnected";
  static const String internetDisconnected = "internetDisconnected";
  static const String vpnConnected = "vpnConnected";
}
