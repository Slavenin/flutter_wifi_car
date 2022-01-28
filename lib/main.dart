import 'package:f_wf_car/home_page.dart';
import 'package:f_wf_car/socket_handler.dart';
import 'package:flutter/material.dart';

SocketHandler handler = SocketHandler();

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  handler.tryConnect();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Remote car control',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}
