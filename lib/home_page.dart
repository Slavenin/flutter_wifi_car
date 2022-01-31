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
    return Scaffold(
      body: OnReactive(
        // Will listen to counter1
        () => Row(
          children: socketState.state.socketHasError
              ? <Widget>[const SocketError()]
              : (socketState.state.socketConnected
                  ? <Widget>[
                      const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: ActionButtons(),
                      ),
                      Expanded(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 15, top: 15),
                            child: OnReactive(
                              // Will listen to counter1
                              () => !streamState.state.streamHasError
                                  ? Mjpeg(
                                      fit: BoxFit.fill,
                                      isLive: streamState.state.isRunning,
                                      height:
                                          MediaQuery.of(context).size.height,
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
                                      stream: settingsState.state.streamUrl,
                                    )
                                  : const StreamError(),
                            ),
                          ),
                        ),
                      ),
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
