import 'dart:io';

import 'package:f_wf_car/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mjpeg/flutter_mjpeg.dart';

late final Socket socket;

void main() {
  Socket.connect("192.168.1.1", 2001).then((Socket sock) {
    socket = sock;
    socket.listen(
      dataHandler,
      onError: errorHandler,
      onDone: doneHandler,
      cancelOnError: false,
    );
  });
  //Connect standard in to the socket
  stdin.listen(
    (data) => socket.write(String.fromCharCodes(data).trim() + '\n'),
  );

  runApp(MyApp());
}

void dataHandler(data) {
  print(new String.fromCharCodes(data).trim());
}

void errorHandler(error, StackTrace trace) {
  print(error);
}

void doneHandler() {
  socket.destroy();
}

void onTapCancel() => socket.write("st\n");

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final isRunning = useState(true);

    return Scaffold(
      body: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 50),
                      child: ElevatedButton(
                        onPressed: () {
                          isRunning.value = !isRunning.value;
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: (isRunning.value
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off)),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    MoveButton(
                      onTapCancel: onTapCancel,
                      onUpdate: () => socket.write("fw\n"),
                      buttonData:
                          const Icon(Icons.arrow_upward, color: Colors.white),
                    )
                  ],
                ),
                Row(
                  children: [
                    MoveButton(
                      onTapCancel: onTapCancel,
                      onUpdate: () => socket.write("lf\n"),
                      buttonData:
                          const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    MoveButton(
                      onTapCancel: onTapCancel,
                      onUpdate: () => socket.write("rg\n"),
                      buttonData:
                          const Icon(Icons.arrow_forward, color: Colors.white),
                    ),
                  ],
                ),
                Row(
                  children: [
                    MoveButton(
                      onTapCancel: onTapCancel,
                      onUpdate: () => socket.write("bw\n"),
                      buttonData:
                          const Icon(Icons.arrow_downward, color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15, top: 15),
                child: Mjpeg(
                  fit: BoxFit.fill,
                  isLive: isRunning.value,
                  height: MediaQuery.of(context).size.height,
                  // width: MediaQuery.of(context).size.width,
                  error: (context, error, stack) {
                    print(error);
                    print(stack);
                    return Text(
                      error.toString(),
                      style: const TextStyle(color: Colors.red),
                    );
                  },
                  stream: 'http://192.168.1.1:8080/?action=stream',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
