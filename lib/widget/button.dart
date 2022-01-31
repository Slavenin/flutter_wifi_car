import 'package:f_wf_car/widget/button_tap_handler.dart';
import 'package:flutter/material.dart';

class MoveButton extends StatelessWidget {
  final VoidCallback onUpdate;
  final VoidCallback onTapCancel;
  final Widget buttonData;

  const MoveButton(
      {Key? key,
      required this.onTapCancel,
      required this.onUpdate,
      required this.buttonData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ButtonTapHandler(
        onUpdate: onUpdate,
        onTapCancel: onTapCancel,
        child: Ink(
          width: 80,
          height: 60,
          decoration: const BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          child: Center(
            child: buttonData,
          ),
        ),
      ),
    );
  }
}
