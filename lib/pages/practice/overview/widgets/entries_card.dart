import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:practice_repository/practice_repository.dart';

class EntriesCard extends StatelessWidget {
  const EntriesCard({Key? key, this.entries}) : super(key: key);

  final List<FinisherEntry>? entries;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
              // Subtracting from length to reverse order entries are shown
              child: EntryCard(entry: entries?[entries!.length - 1 - index]),
            );
          },
          itemCount: entries?.length ?? 0,
        ),
      ),
    );
  }
}

class EntryCard extends StatelessWidget {
  const EntryCard({
    Key? key,
    required this.entry,
  }) : super(key: key);

  final FinisherEntry? entry;

  String _prettyPrintDuration(Duration? duration) {
    if (duration == null) return "---";

    final output = duration.toString();

    return output.substring(output.indexOf(":") + 1);
  }

  Widget? _StrokeIcon(Stroke? stroke) {
    late final String text;
    late final Color color;
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
    return Container(
      width: 60,
      height: 60,
      child: Center(child: Text(text)),
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 75, maxHeight: 175),
      child: Container(
        height: MediaQuery.of(context).size.height / 10,
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColorLight,
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
                    entry?.name ?? "---",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                )
              ]),
              flex: 4,
            ),
            _StrokeIcon(entry?.stroke) ?? Container(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Expanded(
                    flex: 8,
                    child: Text(
                      _prettyPrintDuration(entry?.time),
                      textAlign: TextAlign.end,
                      overflow: TextOverflow.clip,
                      maxLines: 1,
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          ?.copyWith(fontWeight: FontWeight.w300),
                    ),
                  ),
                  Expanded(
                    child: Container(),
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
