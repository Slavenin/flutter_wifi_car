import 'dart:async';

import 'package:f_wf_car/main.dart';
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
    final _sliderUD = 5.0.inj();
    final _sliderT = 135.0.inj();

    Timer? _debounceUD;
    Timer? _debounceT;

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
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width: sWidth / 3,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      RotatedBox(
                                        quarterTurns: 1,
                                        child: OnReactive(
                                          () => Slider(
                                            value: _sliderUD.state,
                                            max: 100,
                                            min: 2,
                                            divisions: 10,
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
                                                    'cud${newValue.toInt()}');
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
                                            max: 360,
                                            min: 5,
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
                                                    'ct${newValue.toInt()}');
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
    );
  }
}
