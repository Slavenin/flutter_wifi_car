import 'package:states_rebuilder/states_rebuilder.dart';

class StreamState {
  bool isRunning = false;
  bool streamHasError = false;
  dynamic streamError;
}

final Injected<StreamState> streamState = RM.inject<StreamState>(
  () => StreamState(),
  debugPrintWhenNotifiedPreMessage: 'StreamState',
);
