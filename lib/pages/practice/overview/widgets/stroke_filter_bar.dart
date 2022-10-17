import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:practice_repository/practice_repository.dart';

class StrokeFilterBar extends StatelessWidget {
  const StrokeFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StrokeButton(
          stroke: Stroke.FREE_STYLE,
        ),
        StrokeButton(
          stroke: Stroke.BACK_STROKE,
        ),
        StrokeButton(
          stroke: Stroke.BREAST_STROKE,
        ),
        StrokeButton(
          stroke: Stroke.BUTTERFLY,
        ),
      ],
    );
  }
}

class StrokeButton extends StatelessWidget {
  StrokeButton({
    Key? key,
    required this.stroke,
  }) : super(key: key) {
    switch (stroke) {
      case Stroke.FREE_STYLE:
        color = Colors.green;
        text = "FR";
        break;
      case Stroke.BACK_STROKE:
        color = Colors.red;
        text = "BA";
        break;
      case Stroke.BREAST_STROKE:
        color = Colors.orange;
        text = "BR";
        break;
      case Stroke.BUTTERFLY:
        color = Colors.lightBlue;
        text = "FL";
        break;
      default:
    }
  }

  final Stroke stroke;
  late final Color color;
  late final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Text(text),
      style: ButtonStyle(
        shape: MaterialStateProperty.all(CircleBorder()),
        padding: MaterialStateProperty.all(EdgeInsets.all(20)),
        backgroundColor: MaterialStateProperty.all(color), // <-- Button color
        overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
          if (states.contains(MaterialState.pressed)) {
            return color; // <-- Splash color
          }
        }),
      ),
    );
  }
}
