import 'package:states_rebuilder/states_rebuilder.dart';

class StreamState {
  bool isRunning = false;
  bool streamHasError = false;
  dynamic streamError;

  @override
  String toString() {
    return 'StreamState{isRunning: $isRunning, streamHasError: $streamHasError, streamError: $streamError}';
  }
}

final Injected<StreamState> streamState = RM.inject<StreamState>(
  () => StreamState(),
  debugPrintWhenNotifiedPreMessage: 'StreamState',
);
