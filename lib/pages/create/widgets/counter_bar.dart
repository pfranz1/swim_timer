import 'dart:math';

import 'package:animated_digit/animated_digit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class CounterBar extends StatefulWidget {
  final int initialCount;

  const CounterBar({
    super.key,
    this.initialCount = 6,
  });

  @override
  State<CounterBar> createState() => _CounterBarState();
}

class _CounterBarState extends State<CounterBar> {
  late int count;

  AnimatedDigitController _controller = AnimatedDigitController(6);

  @override
  void initState() {
    super.initState();

    count = widget.initialCount;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SideButton(
          color: Colors.red,
          icon: Icon(
            Icons.remove,
            color: Colors.white,
          ),
          onTap: () {
            setState(() {
              count = max(1, count - 1);
            });
          },
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 6),
          child: Text(
            count.toString(),
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        SideButton(
          //TODO Real color
          color: Colors.green,
          icon: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onTap: () {
            setState(() {
              count = min(6, count + 1);
            });
          },
        ),
      ],
    );
  }
}

class SideButton extends StatelessWidget {
  SideButton({
    Key? key,
    required this.color,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  final Color color;
  final Widget icon;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.all(Radius.circular(16.0)),
      child: InkWell(
        onTap: onTap,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: icon,
          ),
        ),
      ),
    );
  }
}
