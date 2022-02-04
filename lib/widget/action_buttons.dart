import 'package:f_wf_car/main.dart';
import 'package:f_wf_car/state/settings_state.dart';
import 'package:f_wf_car/state/stream_state.dart';
import 'package:f_wf_car/widget/button.dart';
import 'package:f_wf_car/widget/settings_button.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class ActionButtons extends StatelessWidget {
  String forward;
  String toLeft;
  String toRight;
  String backward;

  bool showSettings = true;

  ActionButtons(this.forward, this.toLeft, this.toRight, this.backward,
      {Key? key, this.showSettings = true})
      : super(key: key);

  void onTapCancel() => handler.sendData(settingsState.state.stop);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        showSettings
            ? Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 30, right: 5),
                    child: SettingsButton(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30, left: 5),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Colors.blue.withOpacity(0.5),
                        ),
                      ),
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
              )
            : Container(),
        Row(
          children: const [
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Text(
                "Robot control",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        Row(
          children: [
            MoveButton(
              onTapCancel: onTapCancel,
              onUpdate: () {
                handler.sendData(forward);
              },
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
                onUpdate: () => handler.sendData(toLeft),
                buttonData: const Icon(Icons.arrow_back, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: MoveButton(
                onTapCancel: onTapCancel,
                onUpdate: () => handler.sendData(toRight),
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
              onUpdate: () => handler.sendData(backward),
              buttonData: const Icon(Icons.arrow_downward, color: Colors.white),
            ),
          ],
        ),
      ],
    );
  }
}
