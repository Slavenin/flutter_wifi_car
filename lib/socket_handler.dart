import 'dart:io';

import 'package:f_wf_car/state/app_state.dart';

class SocketHandler {
  void tryConnect() {
    Socket.connect("192.168.1.1", 2001).then((Socket sock) {
      sock.listen(
        dataHandler,
        onError: errorHandler,
        onDone: doneHandler,
        cancelOnError: false,
      );

      appState.setState((s) {
        s.socket = sock;
        s.socketConnected = true;
      });
    }).catchError((e) {});
  }

  void dataHandler(data) {
    if (appState.state.showIngoingMessage) {
      appState.setState((s) {
        s.ingoingMessages.insert(0, data);
      });
    }
  }

  void errorHandler(error) {
    appState.setState((s) {
      s.socketConnected = false;
      s.socketHasError = true;
      s.socketError = error;
    });
  }

  void doneHandler() {
    appState.state.socket.destroy();
    appState.setState((s) {
      s.socketConnected = false;
    });
  }

  void sendData(String data) {
    appState.state.socketConnected
        ? appState.state.socket.write("$data\n")
        : null;
  }
}
