import 'dart:io';

import 'package:states_rebuilder/states_rebuilder.dart';

class SocketState {
  late Socket socket;
  List<String> ingoingMessages = [];
  bool socketConnected = false;
  bool socketHasError = false;
  dynamic socketError;
}

final Injected<SocketState> socketState = RM.inject<SocketState>(
  () => SocketState(),
  debugPrintWhenNotifiedPreMessage: 'SocketState',
);
