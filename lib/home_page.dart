import 'package:f_wf_car/socket_handler.dart';
import 'package:f_wf_car/state/app_state.dart';
import 'package:f_wf_car/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mjpeg/flutter_mjpeg.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class MyHomePage extends HookWidget {
  final SocketHandler handler;

  const MyHomePage(this.handler, {Key? key}) : super(key: key);

  void onTapCancel() => handler.sendData(appState.state.stop);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 50),
                      child: ElevatedButton(
                        onPressed: () {
                          appState.setState((s) {
                            s.isRunning = !s.isRunning;
                          });
                        },
                        child: OnReactive(
                          // Will listen to counter1
                          () => Padding(
                            padding: const EdgeInsets.all(10),
                            child: (appState.state.isRunning
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    MoveButton(
                      onTapCancel: onTapCancel,
                      onUpdate: () => handler.sendData(appState.state.forward),
                      buttonData:
                          const Icon(Icons.arrow_upward, color: Colors.white),
                    )
                  ],
                ),
                Row(
                  children: [
                    MoveButton(
                      onTapCancel: onTapCancel,
                      onUpdate: () => handler.sendData(appState.state.toLeft),
                      buttonData:
                          const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    MoveButton(
                      onTapCancel: onTapCancel,
                      onUpdate: () => handler.sendData(appState.state.toRight),
                      buttonData:
                          const Icon(Icons.arrow_forward, color: Colors.white),
                    ),
                  ],
                ),
                Row(
                  children: [
                    MoveButton(
                      onTapCancel: onTapCancel,
                      onUpdate: () => handler.sendData(appState.state.backward),
                      buttonData:
                          const Icon(Icons.arrow_downward, color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
          OnReactive(
            // Will listen to counter1
            () => !appState.state.streamHasError
                ? Expanded(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 15, top: 15),
                        child: Mjpeg(
                          fit: BoxFit.fill,
                          isLive: appState.state.isRunning,
                          height: MediaQuery.of(context).size.height,
                          error: (context, error, stack) {
                            WidgetsBinding.instance!.addPostFrameCallback((_) {
                              appState.setState((s) {
                                s.streamHasError = true;
                                s.streamError = error;
                                s.isRunning = false;
                              });
                            });

                            return Text(
                              error.toString(),
                              style: const TextStyle(color: Colors.red),
                            );
                          },
                          stream: appState.state.streamUrl,
                        ),
                      ),
                    ),
                  )
                : Expanded(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Text(
                          appState.state.streamError.toString(),
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
