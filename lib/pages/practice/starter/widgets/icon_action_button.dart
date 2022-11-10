import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:swim_timer/CustomColors.dart';

class IconActionButton extends StatelessWidget {
  const IconActionButton(
      {super.key,
      required this.onPressed,
      required this.icon,
      required this.isSelected});

  final void Function() onPressed;
  final Widget icon;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Center(child: icon),
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(), //<-- SEE HERE
        padding: EdgeInsets.all(20),
        side: isSelected ? BorderSide(color: Colors.green, width: 5.0) : null,
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
          backgroundColor: CustomColors.primeColor),
      child: Center(
        child: canUndoStart
            ? Icon(Icons.fast_rewind_rounded)
            : Icon(Icons.play_arrow_rounded),
      ),
    );
  }
}
