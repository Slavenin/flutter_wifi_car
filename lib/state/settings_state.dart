import 'dart:convert';

import 'package:states_rebuilder/states_rebuilder.dart';

class SettingsState {
  SettingsState();

  String socketIp = '192.168.1.1';
  int socketPort = 2001;

  String streamUrl = 'http://192.168.1.1:8080/?action=stream';

  bool showIngoingMessage = false;

  String forward = 'fw';
  String backward = 'bw';
  String toLeft = 'lf';
  String toRight = 'rg';
  String stop = 'st';

  String cameraUp = 'stu';
  String cameraDown = 'std';
  String cameraLeft = 'stl';
  String cameraRight = 'str';

  String toJson() {
    return json.encode({
      'socketIp': socketIp,
      'socketPort': socketPort,
      'streamUrl': streamUrl,
      'showIngoingMessage': showIngoingMessage,
      'forward': forward,
      'backward': backward,
      'toLeft': toLeft,
      'toRight': toRight,
      'stop': stop,
      'cameraUp': cameraUp,
      'cameraDown': cameraDown,
      'cameraLeft': cameraLeft,
      'cameraRight': cameraRight,
    });
  }

  SettingsState.fromJson(Map json)
      : socketIp = json['socketIp'],
        socketPort = json['socketPort'],
        streamUrl = json['streamUrl'],
        showIngoingMessage = json['showIngoingMessage'],
        forward = json['forward'],
        backward = json['backward'],
        toLeft = json['toLeft'],
        toRight = json['toRight'],
        stop = json['stop'],
        cameraUp = json['cameraUp'] ?? "stu",
        cameraDown = json['cameraDown'] ?? "std",
        cameraLeft = json['cameraLeft'] ?? 'stl',
        cameraRight = json['cameraRight'] ?? 'str';

  @override
  String toString() {
    return 'SettingsState{socketIp: $socketIp, socketPort: $socketPort, streamUrl: $streamUrl, showIngoingMessage: $showIngoingMessage, forward: $forward, backward: $backward, toLeft: $toLeft, toRight: $toRight, stop: $stop, cameraUp: $cameraUp, cameraDown: $cameraDown, cameraLeft: $cameraLeft, cameraRight: $cameraRight}';
  }
}

final Injected<SettingsState> settingsState = RM.inject<SettingsState>(
  () => SettingsState(),
  persist: () => PersistState(
    key: 'SettingsState',
    toJson: (SettingsState s) => s.toJson(),
    fromJson: (String data) => SettingsState.fromJson(json.decode(data)),
    // Optionally, throttle the state persistance
    throttleDelay: 1000,
  ),
  debugPrintWhenNotifiedPreMessage: 'SettingsState',
);
