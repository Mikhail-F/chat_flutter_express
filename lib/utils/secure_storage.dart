import 'package:auth_flutter_express/api/configure_api.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static Future<void> saveAccessToken({required String token}) async {
    await const FlutterSecureStorage().write(key: "accessToken", value: token);
    await ConfigureApi.setDeviceId();
  }

  static Future<int> getAccessToken() async {
    return int.parse(
        await const FlutterSecureStorage().read(key: "accessToken") ?? "0");
  }

  static Future<void> clearAccessToken() async {
    await const FlutterSecureStorage().delete(key: "accessToken");
    await ConfigureApi.setDeviceId();
  }
}
