import 'package:f_wf_car/main.dart';
import 'package:f_wf_car/state/app_state.dart';
import 'package:f_wf_car/state/stream_state.dart';
import 'package:f_wf_car/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({Key? key}) : super(key: key);

  void onTapCancel() => handler.sendData(settingsState.state.stop);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: ElevatedButton(
                onPressed: () {
                  streamState.setState((s) {
                    s.isRunning = !s.isRunning;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: OnReactive(
                    // Will listen to counter1
                    () => (streamState.state.isRunning
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
              onUpdate: () => handler.sendData(settingsState.state.forward),
              buttonData: const Icon(Icons.arrow_upward, color: Colors.white),
            )
          ],
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: MoveButton(
                onTapCancel: onTapCancel,
                onUpdate: () => handler.sendData(settingsState.state.toLeft),
                buttonData: const Icon(Icons.arrow_back, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: MoveButton(
                onTapCancel: onTapCancel,
                onUpdate: () => handler.sendData(settingsState.state.toRight),
                buttonData:
                    const Icon(Icons.arrow_forward, color: Colors.white),
              ),
            ),
          ],
        ),
        Row(
          children: [
            MoveButton(
              onTapCancel: onTapCancel,
              onUpdate: () => handler.sendData(settingsState.state.backward),
              buttonData: const Icon(Icons.arrow_downward, color: Colors.white),
            ),
          ],
        ),
      ],
    );
  }
}
