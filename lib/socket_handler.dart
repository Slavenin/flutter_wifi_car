import 'dart:io';

import 'package:f_wf_car/state/app_state.dart';
import 'package:f_wf_car/state/socket_state.dart';

class SocketHandler {
  void tryConnect() {
    Socket.connect(settingsState.state.socketIp, settingsState.state.socketPort)
        .then((Socket sock) {
      sock.listen(
        dataHandler,
        onDone: doneHandler,
        cancelOnError: false,
      );

      socketState.setState((s) {
        s.socket = sock;
        s.socketConnected = true;
      });
    }).catchError((e) {
      socketState.setState((s) {
        s.socketConnected = false;
        s.socketHasError = true;
        s.socketError = e;
      });
    });
  }

  void dataHandler(data) {
    if (settingsState.state.showIngoingMessage) {
      socketState.setState((s) {
        s.ingoingMessages.insert(0, data);
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
