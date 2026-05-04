import 'package:auth_flutter_express/presentation/common/check_internet/stream_internet.dart';
import 'package:auth_flutter_express/presentation/utils/constans.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stream_listener/flutter_stream_listener.dart';

class StreamInternetWrapper extends StatelessWidget {
  final Widget child;
  final Function? onUpdate;
  const StreamInternetWrapper({super.key, required this.child, this.onUpdate});

  @override
  Widget build(BuildContext context) {
    return StreamListener(
      stream: StreamInternet.instance.messageStream,
      onData: (message) {
        if (message == StreamInternet.internetDisconnected) {
          showMessege(context: context, error: message);
        } else if (message == StreamInternet.internetConnected) {
          showMessege(context: context, error: message);
          if (onUpdate != null) onUpdate!();
        }
        // else if (message == StreamInternet.vpnConnected) {
        //   AppNavigator.goVpnPlaceholder();
        // }
      },
      child: child,
    );
  }
}
