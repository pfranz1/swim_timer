import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:practice_repository/practice_repository.dart';
import 'package:swim_timer/pages/practice/stopper/stopper_bloc/stopper_bloc.dart';
import 'package:swim_timer/pages/practice/stopper/widgets/swimmer_tile.dart';
import 'package:provider/provider.dart';

class Lanes extends StatelessWidget {
  const Lanes({super.key, required this.swimmersByLane, this.latestFinishers});

  final List<List<Swimmer>> swimmersByLane;
  final List<Swimmer?>? latestFinishers;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3 / 2,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemBuilder: (context, index) {
          return Lane(
            swimmers: swimmersByLane[index + 1],
            laneNum: index + 1,
            latestFinisher:
                latestFinishers != null ? latestFinishers![index + 1] : null,
          );
        },
        // Need to remove lane 0
        itemCount: swimmersByLane.length - 1,
      ),
    );
  }
}

class Lane extends StatelessWidget {
  final List<Swimmer> swimmers;
  final Swimmer? latestFinisher;
  final int laneNum;

  static const Duration _undoShowDuration = const Duration(seconds: 5);

  const Lane(
      {super.key,
      required this.swimmers,
      required this.laneNum,
      required this.latestFinisher});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).primaryColorLight,
        child: Stack(children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: [
                  for (var swimmer in swimmers)
                    SwimmerTile(
                      swimmer: swimmer,
                      onTap: () => context.read<StopperBloc>().add(TapSwimmer(
                          lane: laneNum,
                          swimmer: swimmer,
                          time: DateTime.now())),
                    )
                ],
              ),
            ),
          ),
          if (latestFinisher != null)
            Align(
              alignment: Alignment.bottomLeft,
              child: IconButton(
                icon: Icon(Icons.undo),
                onPressed: (() => context.read<StopperBloc>().add(TapUndo(
                    id: latestFinisher!.id,
                    startTime: latestFinisher!.startTime!,
                    lane: laneNum))),
              ),
            )
        ]));
  }
}
