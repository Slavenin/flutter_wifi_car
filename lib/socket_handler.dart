import 'dart:io';

import 'package:f_wf_car/state/app_state.dart';

class SocketHandler {
  void tryConnect() {
    Socket.connect(appState.state.socketIp, appState.state.socketPort)
        .then((Socket sock) {
      sock.listen(
        dataHandler,
        onDone: doneHandler,
        cancelOnError: false,
      );

      appState.setState((s) {
        s.socket = sock;
        s.socketConnected = true;
      });
    }).catchError((e) {
      appState.setState((s) {
        s.socketConnected = false;
        s.socketHasError = true;
        s.socketError = e;
      });
    });
  }

  void dataHandler(data) {
    if (appState.state.showIngoingMessage) {
      appState.setState((s) {
        s.ingoingMessages.insert(0, data);
      });
    }
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
