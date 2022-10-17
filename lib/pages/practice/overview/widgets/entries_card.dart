import 'package:flutter/material.dart';
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
    return duration.toString();
  }

  Widget? _StrokeIcon(Stroke? stroke) {
    return Icon(Icons.pool);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColorLight,
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Center(child: Text(entry?.name ?? "---")),
            flex: 4,
          ),
          _StrokeIcon(entry?.stroke) ?? Container(),
          Expanded(
            child: Center(child: Text(_prettyPrintDuration(entry?.time))),
            flex: 4,
          ),
        ],
      ),
    );
  }
}
