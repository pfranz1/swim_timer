import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:practice_repository/practice_repository.dart';
import 'package:entities/entities.dart';
import 'package:swim_timer/custom_colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class EntriesCard extends StatelessWidget {
  const EntriesCard({Key? key, this.entries}) : super(key: key);

  final List<FinisherEntry>? entries;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: CustomColors.primeColor,
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: entries != null
            ? ListView.builder(
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 3.0),
                    // Subtracting from length to reverse order entries are shown
                    child:
                        EntryCard(entry: entries![entries!.length - 1 - index]),
                  );
                },
                itemCount: entries?.length ?? 0,
              )
            : Center(child: Text("No times recorded yet...")),
      ),
    );
  }
}

class EntryCard extends StatelessWidget {
  EntryCard({
    Key? key,
    required this.entry,
  }) : super(key: key) {
    modifiedName = entry.name.replaceAll(" ", "\n");
  }

  final FinisherEntry entry;
  late final String modifiedName;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 75, maxHeight: 175),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: CustomColors.primeColor,
          padding: EdgeInsets.zero,
        ),
        child: Container(
          height: MediaQuery.of(context).size.height / 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: StrokeIcon(stroke: entry.stroke),
              ),
              // Name
              Expanded(
                flex: 3,
                child: SwimmerName(modifiedName: modifiedName),
              ),
              Expanded(
                child: PerformanceChart(previousTimes: entry.previousTimes),
                flex: 5,
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      flex: 8,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // Lap Time
                          LapTimeText(
                            duration: entry.time,
                          ),
                          // Difference with last time
                          DifferenceText(
                            difference: entry.differenceWithLastTime,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(),
                    ),
                  ],
                ),
                flex: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SwimmerName extends StatelessWidget {
  const SwimmerName({
    Key? key,
    required this.modifiedName,
  }) : super(key: key);

  final String modifiedName;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Padding(
        padding: EdgeInsets.all(4),
        child: Text(modifiedName,
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.headline5),
      ),
    );
  }
}

class PerformanceChart extends StatelessWidget {
  PerformanceChart({super.key, required this.previousTimes});

  List<Duration>? previousTimes;

  @override
  Widget build(BuildContext context) {
    if (previousTimes == null || previousTimes!.length <= 1) {
      return Container(
        child: Center(
          child: Text("---"),
        ),
      );
    }

    return Container(
      child: SfCartesianChart(
          // backgroundColor: Colors.red,
          primaryXAxis: NumericAxis(
            isVisible: true,
            interval: 1,
          ),
          primaryYAxis: NumericAxis(
            isVisible: true,
            maximumLabels: 3,
            desiredIntervals: 2,
            // rangeController: ,
            axisLabelFormatter: (axisLabelRenderArgs) =>
                ChartAxisLabel("", null),
            visibleMinimum: 0,
          ),
          annotations: [
            CartesianChartAnnotation(
                widget: Container(child: const Text('Text')),
                // Coordinate unit type
                coordinateUnit: CoordinateUnit.logicalPixel,
                x: 150,
                y: 200)
          ],
          plotAreaBorderWidth: 0,
          series: [
            LineSeries<Duration, int>(
              color: CustomColors.primeColor,
              dataSource: previousTimes!,
              yValueMapper: (datum, index) => datum.inMilliseconds,
              xValueMapper: (datum, index) => index,
            ),
          ]),
    );
  }
}

class StrokeIcon extends StatelessWidget {
  const StrokeIcon({super.key, required this.stroke});

  final Stroke? stroke;
  @override
  Widget build(BuildContext context) {
    late final String text;
    late final Color color;
    switch (stroke) {
      case Stroke.FREE_STYLE:
        color = Color(0xFF62CA50);
        text = "FR";
        break;
      case Stroke.BACK_STROKE:
        color = Color(0xFFD42A34);
        text = "BA";
        break;
      case Stroke.BREAST_STROKE:
        color = Color(0xFFF78C37);
        text = "BR";
        break;
      case Stroke.BUTTERFLY:
        color = Color(0xFF0677BA);
        text = "FL";
        break;
      default:
        color = Colors.grey;
        text = "?";
    }
    return Container(
      width: 60,
      height: 60,
      child: Center(
          child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      )),
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}

class DifferenceText extends StatelessWidget {
  DifferenceText({super.key, double? difference})
      : differenceText = _formatDiffDouble(difference),
        color = _colorFromDiff(difference);

  static String _formatDiffDouble(double? difference) {
    if (difference == null) return "---";
    return (difference.sign > 0 ? "+" : "") + difference.toStringAsFixed(2);
  }

  static Color _colorFromDiff(double? difference) {
    if (difference == null || difference == null) return Colors.black;
    return (difference < 0)
        ? CustomColors.primaryGreen
        : CustomColors.primaryRed;
  }

  final String differenceText;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      differenceText,
      style: TextStyle(
        color: color,
        fontSize: 13,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class LapTimeText extends StatelessWidget {
  LapTimeText({super.key, required this.duration})
      : durationText = _formatDuration(duration);

  static final matchTailZeros = RegExp("0+\$");
  static final matchLeadingZeroAndColons = RegExp("^0+((:0*)?)*");

  // I dont know why this doesn't work, was matching too much and not excluding first group
  // static final matchDigitsAfterPrecision = RegExp("(?<=\..{3})(.*)\$");

  static const int precision = 2;

  static String _formatDuration(Duration duration) {
    final output = duration
        .toString()
        .replaceAll(matchTailZeros, "")
        .replaceAll(matchLeadingZeroAndColons, "");

    return output.substring(0, output.lastIndexOf(".") + precision + 1);
  }

  final Duration duration;
  final String durationText;

  @override
  Widget build(BuildContext context) {
    return Text(
      durationText,
      style: TextStyle(
          fontSize: 20,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w300,
          color: CustomColors.primeColor),
    );
  }
}
