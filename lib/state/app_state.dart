import 'package:states_rebuilder/states_rebuilder.dart';

class SettingsState {
  String socketIp = '192.168.1.1';
  int socketPort = 2001;

  String streamUrl = 'http://192.168.1.1:8080/?action=stream';

  bool showIngoingMessage = false;

  String forward = 'fw';
  String backward = 'bw';
  String toLeft = 'lf';
  String toRight = 'rg';
  String stop = 'st';

  @override
  String toString() {
    return 'SettingsState{socketIp: $socketIp, socketPort: $socketPort, streamUrl: $streamUrl, showIngoingMessage: $showIngoingMessage, forward: $forward, backward: $backward, toLeft: $toLeft, toRight: $toRight, stop: $stop}';
  }
}

final Injected<SettingsState> settingsState = RM.inject<SettingsState>(
  () => SettingsState(),
  debugPrintWhenNotifiedPreMessage: 'AppState',
);
