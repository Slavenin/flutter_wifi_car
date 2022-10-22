import 'package:flutter/material.dart';

class ButtonTapHandler extends StatefulWidget {
  /// Update callback
  final VoidCallback onUpdate;
  final VoidCallback onTapCancel;

  /// Minimum delay between update events when holding the button
  final int minDelay;

  /// Initial delay between change events when holding the button
  final int initialDelay;

  /// Number of steps to go from [initialDelay] to [minDelay]
  final int delaySteps;

  /// Icon on the button
  final Widget child;

  const ButtonTapHandler(
      {Key? key,
      required this.onUpdate,
      this.minDelay = 150,
      this.initialDelay = 300,
      this.delaySteps = 5,
      required this.child,
      required this.onTapCancel})
      : assert(minDelay <= initialDelay,
            "The minimum delay cannot be larger than the initial delay"),
        super(key: key);

  @override
  _ButtonTapHandlerState createState() => _ButtonTapHandlerState();
}

class _ButtonTapHandlerState extends State<ButtonTapHandler> {
  /// True if the button is currently being held
  bool _holding = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(5),
      color: Theme.of(context).dividerColor,
      child: InkWell(
        child: widget.child,
        radius: 25,
        onTap: () => _stopHolding(),
        onTapDown: (_) => _startHolding(),
        onTapCancel: () => _stopHolding(),
      ),
    );
  }

  void _startHolding() async {
    // Make sure this isn't called more than once for
    // whatever reason.
    if (_holding) return;
    _holding = true;

    // Calculate the delay decrease per step
    final step =
        (widget.initialDelay - widget.minDelay).toDouble() / widget.delaySteps;
    var delay = widget.initialDelay.toDouble();

    while (_holding) {
      widget.onUpdate();
      await Future.delayed(Duration(milliseconds: delay.round()));
      if (delay > widget.minDelay) delay -= step;
    }
    widget.onTapCancel();
  }

  void _stopHolding() {
    _holding = false;
  }
}
