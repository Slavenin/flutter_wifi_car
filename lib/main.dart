import 'package:f_wf_car/home_page.dart';
import 'package:f_wf_car/socket_handler.dart';
import 'package:f_wf_car/state/hive_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

SocketHandler handler = SocketHandler();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await RM.storageInitializer(HiveStorage());

  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight])
      .then((value) {
    handler.tryConnect();
    runApp(const MyApp());
  });
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
