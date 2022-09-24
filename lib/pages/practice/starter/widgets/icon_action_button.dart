import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class IconActionButton extends StatelessWidget {
  const IconActionButton(
      {super.key, required this.onPressed, required this.icon});

  final void Function() onPressed;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: icon,
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(), //<-- SEE HERE
        padding: EdgeInsets.all(20),
      ),
    );
  }
}

class IconStartButton extends StatelessWidget {
  const IconStartButton(
      {super.key,
      required this.canUndoStart,
      required this.onStart,
      required this.onUndo});

  final bool canUndoStart;

  final void Function() onStart;

  final void Function() onUndo;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: canUndoStart ? onUndo : onStart,
      style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(30),
          backgroundColor: Colors.orange),
      child: canUndoStart
          ? Icon(Icons.fast_rewind_rounded)
          : Icon(Icons.play_arrow_rounded),
    );
  }
}
