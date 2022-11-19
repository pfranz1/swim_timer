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
  const EntryCard({
    Key? key,
    required this.entry,
  }) : super(key: key);

  final FinisherEntry entry;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 75, maxHeight: 175),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: CustomColors.primeColor,
        ),
        child: Container(
          height: MediaQuery.of(context).size.height / 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 16,
              ),
              StrokeIcon(stroke: entry.stroke),
              // Name + Spacer
              Expanded(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  // Spacer
                  Expanded(
                    child: Container(),
                    flex: 2,
                  ),
                  // Name
                  Expanded(
                    flex: 8,
                    child: Text(entry.name,
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.headline5),
                  ),
                ]),
                flex: 4,
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

class PerformanceChart extends StatelessWidget {
  PerformanceChart({super.key, required this.previousTimes});

  List<Duration>? previousTimes;

  @override
  Widget build(BuildContext context) {
    if (previousTimes == null) {
      return Container(
        child: Center(
          child: Text("---"),
        ),
      );
    }

    return Container(
      child: SfCartesianChart(
          primaryXAxis: NumericAxis(),
          primaryYAxis: NumericAxis(),
          series: [
            LineSeries<Duration, int>(
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

  static String _formatDuration(Duration duration) {
    return duration
        .toString()
        .replaceAll(matchTailZeros, "")
        .replaceAll(matchLeadingZeroAndColons, "");
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
