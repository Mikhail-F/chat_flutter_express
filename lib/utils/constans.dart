import 'package:auth_flutter_express/utils/custom_theme.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

Future<bool> checkInternetConnection() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  bool isConnect = false;

  if (connectivityResult == ConnectivityResult.mobile ||
      connectivityResult == ConnectivityResult.wifi) isConnect = true;
  return isConnect;
}

enum AllExceptionsApi {
  network,
  data,
}

showMessege({required BuildContext context, required Object error}) {
  ScaffoldMessenger.maybeOf(context)?.clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        error.toString(),
      ),
      behavior: SnackBarBehavior.floating,
    ),
  );
}

CustomThemeColor getThemeData(BuildContext context) {
  return Theme.of(context).extension<CustomThemeColor>()!;
}
