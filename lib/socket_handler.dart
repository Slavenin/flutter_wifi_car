import 'dart:io';

import '/state/settings_state.dart';
import '/state/socket_state.dart';

class SocketHandler {
  void tryConnect() {
    Socket.connect(
      settingsState.state.socketIp,
      settingsState.state.socketPort,
      timeout: const Duration(seconds: 5),
    ).then((Socket sock) {
      sock.listen(
        dataHandler,
        onDone: doneHandler,
        onError: errorHandler,
        cancelOnError: true,
      );

      socketState.setState((s) {
        s.socket = sock;
        s.socketConnected = true;
        s.socketHasError = false;
        s.socketError = null;
      });
    }).catchError((e) {
      socketState.setState((s) {
        s.socketConnected = false;
        s.socketHasError = true;
        s.socketError = e;
      });
    });
  }

  void errorHandler(error) {
    socketState.setState((s) {
      s.socketConnected = false;
      s.socketHasError = true;
      s.socketError = error;
    });
  }

  void dataHandler(data) {
    if (settingsState.state.showIngoingMessage) {
      socketState.setState((s) {
        s.ingoingMessages.insert(0, String.fromCharCodes(data));
      });
    }
  }

  void doneHandler() {
    socketState.state.socket.destroy();
    socketState.setState((s) {
      s.socketConnected = false;
    });
  }

  void sendData(String data) {
    socketState.state.socketConnected
        ? socketState.state.socket.write("$data\n")
        : null;
  }
}
