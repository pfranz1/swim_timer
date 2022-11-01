import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:practice_repository/practice_repository.dart';
import 'package:entities/entities.dart';

class EntriesCard extends StatelessWidget {
  const EntriesCard({Key? key, this.entries}) : super(key: key);

  final List<FinisherEntry>? entries;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color(0xFF10465F),
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

  String _prettyPrintDuration(Duration? duration) {
    if (duration == null) return "---";

    final output = duration.toString();

    return output.substring(output.indexOf(":") + 1);
  }

  String _prettyPrintDifference(double? diff) {
    if (diff == null) return "---";
    return diff.toStringAsPrecision(2);
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 75, maxHeight: 175),
      child: Container(
        height: MediaQuery.of(context).size.height / 10,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Expanded(
                  child: Container(),
                  flex: 2,
                ),
                Expanded(
                  flex: 8,
                  child: Text(
                    entry.name,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                )
              ]),
              flex: 4,
            ),
            StrokeIcon(stroke: entry.stroke),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child:
                    Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Expanded(
                      flex: 3,
                      child: LapTimeText(
                        duration: entry.time,
                      )),
                  Expanded(
                    child: Container(
                        child: DifferenceText(
                      difference: entry.differenceWithLastTime,
                    )),
                    flex: 2,
                  ),
                ]),
              ),
              flex: 4,
            ),
          ],
        ),
      ),
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
      : differenceText = _formatDiffDouble(difference);

  static String _formatDiffDouble(double? difference) {
    if (difference == null) return "---";
    return (difference.sign > 0 ? "+" : "") + difference.toStringAsPrecision(2);
  }

  final String differenceText;

  @override
  Widget build(BuildContext context) {
    return Text(differenceText);
  }
}

class LapTimeText extends StatelessWidget {
  LapTimeText({super.key, required this.duration})
      : durationText = _formatDuration(duration);

  static String _formatDuration(Duration duration) {
    final output = duration.toString();

    return output.substring(output.indexOf(":") + 1);
  }

  final Duration duration;
  final String durationText;

  @override
  Widget build(BuildContext context) {
    return Text(durationText);
  }
}
