import 'package:f_wf_car/state/stream_state.dart';
import 'package:flutter/material.dart';

class StreamError extends StatelessWidget {
  const StreamError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 50, right: 50, bottom: 30),
          child: Text(
            streamState.state.streamError.toString(),
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.red),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            streamState.setState((s) {
              s.streamHasError = false;
              s.streamError = null;
              s.isRunning = false;
            });
          },
          child: const Padding(
            padding: EdgeInsets.all(10),
            child: Text("Try again"),
          ),
        ),
      ],
    );
  }
}
