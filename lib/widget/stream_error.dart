import 'package:flutter/material.dart';

import '/state/stream_state.dart';

class StreamError extends StatelessWidget {
  const StreamError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 500,
              child: Padding(
                padding: const EdgeInsets.only(left: 50, right: 50, bottom: 30),
                child: Text(
                  streamState.state.streamError.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red),
                ),
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
        ),
      ],
    );
  }
}
