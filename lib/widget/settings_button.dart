import 'package:f_wf_car/widget/settings_from.dart';
import 'package:flutter/material.dart';

class SettingsButton extends StatelessWidget {
  const SettingsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: ElevatedButton(
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
      ),
    );
  }
}
