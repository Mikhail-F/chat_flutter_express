import 'package:auth_flutter_express/api/configure_api.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class MainSocket {
  IO.Socket? socket;
  static MainSocket? _instance;

  static MainSocket get instance => _instance ??= MainSocket._connect();

  MainSocket._connect() {
    // https://chat-3mhd.onrender.com
    socket = IO.io(ConfigureApi.getUrl(), <String, dynamic>{
      "transports": ['websocket'],
      "autoConnect": false,
    });
    socket!.connect();
    socket!.onConnect((data) => {print("Flutter connect to socket")});
  }
}
