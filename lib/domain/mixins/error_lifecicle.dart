import 'package:auth_flutter_express/presentation/common/check_internet/stream_internet.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

mixin class ErrorLifecicle {
  bool isLoading = true;
  bool isConnect = true;
  bool isError = false;
  bool firstLoad = false;

  Future<bool> checkConnect() async {
    final List<ConnectivityResult> connections =
        await StreamInternet.instance.checkConnect;
    bool result = connections.contains(ConnectivityResult.wifi) ||
        connections.contains(ConnectivityResult.mobile) ||
        connections.contains(ConnectivityResult.vpn);
    isConnect = result;
    if (!isConnect) isLoading = false;
    return result;
  }

  void setDefaultLifecicle() {
    isLoading = true;
    isError = false;
    firstLoad = false;
  }

  static const errorInternetConnection = "errorInternetConnection";
}
