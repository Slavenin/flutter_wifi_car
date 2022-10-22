import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import '/state/settings_state.dart';

class SettingsForm extends StatelessWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //move
    final forwardText = RM.injectTextEditing(
        text: settingsState.state.forward,
        onTextEditing: (text) {
          if (text.isValid) {
            settingsState.setState((s) {
              s.forward = text.controller.value.text;
            });
          }
        });
    final backwardText = RM.injectTextEditing(
        text: settingsState.state.backward,
        onTextEditing: (text) {
          if (text.isValid) {
            settingsState.setState((s) {
              s.backward = text.controller.value.text;
            });
          }
        });
    final toLeftText = RM.injectTextEditing(
        text: settingsState.state.toLeft,
        onTextEditing: (text) {
          if (text.isValid) {
            settingsState.setState((s) {
              s.toLeft = text.controller.value.text;
            });
          }
        });
    final toRightText = RM.injectTextEditing(
        text: settingsState.state.toRight,
        onTextEditing: (text) {
          if (text.isValid) {
            settingsState.setState((s) {
              s.toRight = text.controller.value.text;
            });
          }
        });
    //camera
    final cameraUD = RM.injectTextEditing(
        text: settingsState.state.cameraUD,
        onTextEditing: (text) {
          if (text.isValid) {
            settingsState.setState((s) {
              s.cameraUD = text.controller.value.text;
            });
          }
        });

    final cameraLR = RM.injectTextEditing(
        text: settingsState.state.cameraLR,
        onTextEditing: (text) {
          if (text.isValid) {
            settingsState.setState((s) {
              s.cameraLR = text.controller.value.text;
            });
          }
        });

    //sockets
    final socketIp = RM.injectTextEditing(
        text: settingsState.state.socketIp,
        validators: [
          (String? value) {
            if (null != value) {
              RegExp regExp = RegExp(
                r"^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$",
                caseSensitive: false,
                multiLine: false,
              );

              if (!regExp.hasMatch(value)) {
                return 'IP must be in format 1.2.3.4';
              }
            }

            return null;
          },
        ],
        validateOnTyping: true,
        onTextEditing: (socketIp) {
          if (socketIp.isValid) {
            settingsState.setState((s) {
              s.socketIp = socketIp.controller.value.text;
            });
          }
        });

    final socketPort = RM.injectTextEditing(
        text: settingsState.state.socketPort.toString(),
        validators: [
          (String? value) {
            if (null != value) {
              int? port = int.tryParse(value);
              if (port == null || port <= 0) {
                return "Port must be a positive integer";
              }
            }

            return null;
          }
        ],
        validateOnTyping: true,
        validateOnLoseFocus: true,
        onTextEditing: (socketPort) {
          if (socketPort.isValid) {
            settingsState.setState((s) {
              s.socketPort = int.parse(socketPort.controller.value.text);
            });
          }
        });

    final streamUrl = RM.injectTextEditing(
        text: settingsState.state.streamUrl,
        validators: [
          (String? value) {
            if (null != value) {
              RegExp regExp = RegExp(
                r"^http\:\/\/[\w]+",
                caseSensitive: false,
                multiLine: false,
              );

              if (!regExp.hasMatch(value)) {
                return 'Stream url must be in format http://somedomainorip';
              }

              return null;
            }
          }
        ],
        validateOnTyping: true,
        onTextEditing: (streamUrl) {
          if (streamUrl.isValid) {
            settingsState.setState((s) {
              s.streamUrl = streamUrl.controller.value.text;
            });
          }
        });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 50, right: 50, top: 30),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        "Values transmitted for vehicle control",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: TextField(
                            controller: forwardText.controller,
                            focusNode: forwardText.focusNode,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Car forward text',
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: TextField(
                            controller: backwardText.controller,
                            focusNode: backwardText.focusNode,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Car backward text',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: TextField(
                            controller: toLeftText.controller,
                            focusNode: toLeftText.focusNode,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Car to left text',
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: TextField(
                            controller: toRightText.controller,
                            focusNode: toRightText.focusNode,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Car to right text',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        "Values for stream connect",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: TextField(
                            controller: socketIp.controller,
                            focusNode: socketIp.focusNode,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Arduino socket IP',
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: TextField(
                            controller: socketPort.controller,
                            focusNode: socketPort.focusNode,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Arduino socket port (integer)',
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: TextField(
                            controller: streamUrl.controller,
                            focusNode: streamUrl.focusNode,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Camera stream URL',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        "Values transmitted for camera control",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: TextField(
                            controller: cameraUD.controller,
                            focusNode: cameraUD.focusNode,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Camera up/down text',
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: TextField(
                            controller: cameraLR.controller,
                            focusNode: cameraLR.focusNode,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Camera to left/right text',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
