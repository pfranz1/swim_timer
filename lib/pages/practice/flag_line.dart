import 'dart:ui';

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:swim_timer/custom_colors.dart';

class FlagLine extends StatelessWidget {
  const FlagLine({
    this.lineColor,
    this.colors,
    super.key,
  });

  final List<Color>? colors;
  final Color? lineColor;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(85, 25),
      painter: FlagPainter(
        colors: colors ?? [CustomColors.primeColor],
        lineColor: lineColor ?? CustomColors.primeColor,
      ),
    );
  }
}

class FlagPainter extends CustomPainter {
  FlagPainter({
    required this.colors,
    required this.lineColor,
  }) {
    paints = [];
    for (final color in colors) {
      paints.add(Paint()..color = color);
    }

    assert(paints.isNotEmpty);
  }

  final List<Color> colors;
  final Color lineColor;
  late final List<Paint> paints;

  static const double indent = 4.0;
  static const spacingBetweenFlags = 2.0;

  @override
  void paint(Canvas canvas, Size size) {
    final mainLinePaint = Paint()
      ..strokeWidth = 2.5
      ..color = lineColor;

    final double flagHeight = size.height / 2;
    final double flagWidth = flagHeight * 3 / 4;
    final spacePerFlag = flagWidth + (spacingBetweenFlags);

    final workingLength = size.width - (2 * indent);
    final numOfFlags = (workingLength ~/ spacePerFlag);

    // final numOfFlags =
    //     (size.width - (2 * indent) + spacingBetweenFlags) / spacePerFlag;

    var startOfFlag = indent;
    var colorIndex = 0;

    // Draw flags
    for (var flagIndex = 0; flagIndex <= numOfFlags; flagIndex++) {
      final myPath = Path();

      addTriangle(myPath, startOfFlag, flagWidth, flagHeight);

      canvas.drawPath(myPath, paints[colorIndex]);

      //Draw triangle
      // canvas.drawVertices(
      //   Vertices(
      //     VertexMode.triangles,
      //     makeIsoHangingTriangle(startOfFlag, flagWidth, flagHeight),
      //   ),
      //   BlendMode.plus,
      //   paints[colorIndex],
      // );

      startOfFlag += (spacingBetweenFlags + flagWidth);
      colorIndex = (colorIndex + 1) % paints.length;
    }

    // Draw line across canvas in the middle
    final topLeft = Offset(0, 0);
    final topRight = Offset(startOfFlag + spacingBetweenFlags, 0);
    canvas.drawLine(topLeft, topRight, mainLinePaint);
  }

  void addTriangle(
      Path path, double startX, double flatSlideLength, double height) {
    path.addPolygon(
        makeIsoHangingTriangle(startX, flatSlideLength, height), true);
  }

  // Assumes that y = 0
  // Want isosceles triangle, two points on line, one in the middle hanging below
  List<Offset> makeIsoHangingTriangle(
      double startX, double flatSlideLength, double height) {
    return [
      Offset(startX, 0),
      Offset(startX + (flatSlideLength / 2), height),
      Offset(startX + flatSlideLength, 0),
    ];
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // //TODO: implement shouldRepaint
    // throw UnimplementedError();
    return false;
  }
}
