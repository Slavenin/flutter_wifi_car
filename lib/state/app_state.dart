import 'dart:io';

import 'package:states_rebuilder/states_rebuilder.dart';

class AppState {
  String socketIp = '192.168.1.1';
  int socketPort = 2001;
  late Socket socket;
  bool showIngoingMessage = false;
  List<String> ingoingMessages = [];
  bool socketConnected = false;
  bool socketHasError = false;
  dynamic socketError;

  String streamUrl = 'http://192.168.1.1:8080/?action=stream';
  bool isRunning = false;
  bool streamHasError = false;
  dynamic streamError;

  String forward = 'fw';
  String backward = 'bw';
  String toLeft = 'lf';
  String toRight = 'rg';
  String stop = 'st';

  @override
  String toString() {
    return 'AppState{socketIp: $socketIp, socketPort: $socketPort, showIngoingMessage: $showIngoingMessage, ingoingMessages: $ingoingMessages, socketConnected: $socketConnected, socketHasError: $socketHasError, socketError: $socketError, streamUrl: $streamUrl, isRunning: $isRunning, streamHasError: $streamHasError, streamError: $streamError, forward: $forward, backward: $backward, toLeft: $toLeft, toRight: $toRight, stop: $stop}';
  }
}

final Injected<AppState> appState = RM.inject<AppState>(
  () => AppState(),
  debugPrintWhenNotifiedPreMessage: 'AppState',
);
