import 'package:f_wf_car/widget/settings_from.dart';
import 'package:flutter/material.dart';

class SettingsButton extends StatelessWidget {
  const SettingsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          Colors.blue.withOpacity(0.5),
        ),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SettingsForm(),
          ),
        );
      },
      child: const Padding(
        padding: EdgeInsets.all(10),
        child: Icon(Icons.settings),
      ),
    );
  }
}
