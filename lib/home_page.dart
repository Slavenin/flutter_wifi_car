import 'package:f_wf_car/state/settings_state.dart';
import 'package:f_wf_car/state/socket_state.dart';
import 'package:f_wf_car/state/stream_state.dart';
import 'package:f_wf_car/widget/action_buttons.dart';
import 'package:f_wf_car/widget/socket_error.dart';
import 'package:f_wf_car/widget/stream_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mjpeg/flutter_mjpeg.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class MyHomePage extends HookWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double sHeight = MediaQuery.of(context).size.height;
    double sWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: OnReactive(
        () => Row(
          children: socketState.state.socketHasError
              ? <Widget>[const SocketError()]
              : (socketState.state.socketConnected
                  ? <Widget>[
                      SizedBox(
                        width: sWidth,
                        height: sHeight,
                        child: Stack(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: ActionButtons(
                                    settingsState.state.cameraUp,
                                    settingsState.state.cameraLeft,
                                    settingsState.state.cameraRight,
                                    settingsState.state.cameraDown,
                                    showSettings: false,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 15, top: 15),
                              child: OnReactive(
                                () => !streamState.state.streamHasError
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Mjpeg(
                                            fit: BoxFit.fill,
                                            isLive: streamState.state.isRunning,
                                            height: sHeight,
                                            error: (context, error, stack) {
                                              WidgetsBinding.instance!
                                                  .addPostFrameCallback((_) {
                                                streamState.setState((s) {
                                                  s.streamHasError = true;
                                                  s.streamError = error;
                                                  s.isRunning = false;
                                                });
                                              });

                                              return const Text("");
                                            },
                                            stream:
                                                settingsState.state.streamUrl,
                                          ),
                                        ],
                                      )
                                    : const StreamError(),
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: ActionButtons(
                                    settingsState.state.forward,
                                    settingsState.state.toLeft,
                                    settingsState.state.toRight,
                                    settingsState.state.backward,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ]
                  : [
                      const Expanded(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ]),
        ),
      ),
    );
  }
}
