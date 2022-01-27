import 'package:f_wf_car/home_page.dart';
import 'package:f_wf_car/socket_handler.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SocketHandler handler = SocketHandler();
  handler.tryConnect();

  runApp(MyApp(handler));
}

class MyApp extends StatelessWidget {
  final SocketHandler handler;

  const MyApp(this.handler, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Remote car control',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(handler),
    );
  }
}
