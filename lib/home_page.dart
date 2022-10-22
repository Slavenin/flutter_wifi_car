import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mjpeg/flutter_mjpeg.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import '/main.dart';
import '/state/settings_state.dart';
import '/state/socket_state.dart';
import '/state/stream_state.dart';
import '/widget/action_buttons.dart';
import '/widget/socket_error.dart';
import '/widget/stream_error.dart';

class MyHomePage extends HookWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _sliderUD = 0.0.inj();
    final _sliderT = 90.0.inj();

    Timer? _debounceUD;
    Timer? _debounceT;

    double sHeight = MediaQuery.of(context).size.height;
    double sWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
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
                                              isLive:
                                                  streamState.state.isRunning,
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
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    width: sWidth / 3,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Center(
                                          child: Text(
                                            "Camera control",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        RotatedBox(
                                          quarterTurns: 1,
                                          child: OnReactive(
                                            () => Slider(
                                              value: _sliderUD.state,
                                              activeColor: Colors.blue.shade300,
                                              inactiveColor:
                                                  Colors.blue.shade300,
                                              max: 110,
                                              min: 0,
                                              divisions: 9,
                                              label: _sliderUD.state
                                                  .round()
                                                  .toString(),
                                              onChanged: (double newValue) {
                                                _sliderUD.state = newValue;

                                                if (_debounceUD?.isActive ??
                                                    false) {
                                                  _debounceUD?.cancel();
                                                }
                                                _debounceUD = Timer(
                                                    const Duration(
                                                        milliseconds: 200), () {
                                                  handler.sendData(
                                                      '${settingsState.state.cameraUD}${newValue.toInt()}');
                                                  // do something with query
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                        OnReactive(
                                          () {
                                            return Slider(
                                              value: _sliderT.state,
                                              max: 180,
                                              min: 0,
                                              activeColor: Colors.blue.shade300,
                                              inactiveColor:
                                                  Colors.blue.shade300,
                                              divisions: 10,
                                              label: _sliderT.state
                                                  .round()
                                                  .toString(),
                                              onChanged: (double newValue) {
                                                _sliderT.state = newValue;

                                                if (_debounceT?.isActive ??
                                                    false) {
                                                  _debounceT?.cancel();
                                                }
                                                _debounceT = Timer(
                                                    const Duration(
                                                        milliseconds: 200), () {
                                                  handler.sendData(
                                                      '${settingsState.state.cameraLR}${newValue.toInt()}');
                                                  // do something with query
                                                });
                                              },
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
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
      ),
    );
  }
}
