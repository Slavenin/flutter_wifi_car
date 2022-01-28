import 'package:f_wf_car/main.dart';
import 'package:f_wf_car/state/socket_state.dart';
import 'package:flutter/material.dart';

class SocketError extends StatelessWidget {
  const SocketError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 50, right: 50, bottom: 30),
            child: Text(
              socketState.state.socketError.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.red),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              await socketState.setState((s) {
                s.socketHasError = false;
                s.socketError = null;
              });

              handler.tryConnect();
            },
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: Text("Try again"),
            ),
          ),
        ],
      ),
    );
  }
}
