import 'dart:math';

import 'package:animated_digit/animated_digit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:swim_timer/CustomColors.dart';

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

  final AnimatedDigitController _controller = AnimatedDigitController(6);

  static const _maxCount = 6;
  static const _minCount = 1;

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
          color: count != _minCount
              ? CustomColors.primaryRed
              : CustomColors.primaryRed,
          icon: Icon(
            Icons.remove,
            color: Colors.white,
          ),
          onTap: () {
            setState(() {
              count = max(_minCount, count - 1);
            });
          },
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 6),
          child: SizedBox(
            width: 100,
            child: Center(
              child: Text(
                count.toString(),
                style: TextStyle(
                  fontSize: 56,
                  color: CustomColors.primeColor,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        SideButton(
          //TODO Real color
          color: count != _maxCount
              ? CustomColors.primaryGreen
              : CustomColors.primaryGreen,
          icon: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onTap: () {
            setState(() {
              count = min(_maxCount, count + 1);
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
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
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
