import 'dart:io';
import 'package:auth_flutter_express/utils/secure_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ConfigureApi {
  static final xApiKey = '';
  static var xDeviceId = '';
  static var token = 0;
  static const _client_id = 2;
  static const _client_secret = '';

  static final _prodUrl = 'https://chat-3mhd.onrender.com';
  static final _devUrl = 'http://localhost:3000/';

  static String getUrl() {
    // return _buildUrl;
    return _devUrl;
  }

  static final String _url = getUrl();

  static Future<void> setDeviceId() async {
    // if (Platform.isAndroid) {
    //   var build = await DeviceInfoPlugin().androidInfo;
    //   xDeviceId = "${build.id}";
    // } else if (Platform.isIOS) {
    //   var data = await DeviceInfoPlugin().iosInfo;
    //   xDeviceId = "${data.identifierForVendor}";
    // }
    // HiveManager hiveManager = HiveManager();
    int hiveToken = await SecureStorage.getAccessToken();
    token = hiveToken;
    debugPrint("HEADTOKEN - $token");
    return;
  }

  Dio dio() {
    var dio = Dio(BaseOptions(
      baseUrl: _url,
      headers: {
        "token": token
        // "authorization":
        //     'Basic ' + base64Encode(utf8.encode('mirhvost:mirhvost')),
      },
      contentType: Headers.jsonContentType,
      responseType: ResponseType.plain,
    ));

    dio.interceptors.add(InterceptorsWrapper(onError: (error, handler) {
      if (error.response?.statusCode == 403 ||
          error.response?.statusCode == 401) {
            print("EEEEEEEE");
          }
      return handler.next(error);
    }));
    return dio;
  }
}
