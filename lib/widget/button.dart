import 'package:flutter/material.dart';

import '/widget/button_tap_handler.dart';

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
          width: 70,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.5),
            borderRadius: const BorderRadius.all(Radius.circular(5)),
          ),
          child: Center(
            child: buttonData,
          ),
        ),
      ),
    );
  }
}
