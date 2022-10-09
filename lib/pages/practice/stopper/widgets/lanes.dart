import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:practice_repository/practice_repository.dart';
import 'package:swim_timer/pages/practice/stopper/stopper_bloc/stopper_bloc.dart';
import 'package:swim_timer/pages/practice/stopper/widgets/swimmer_tile.dart';
import 'package:provider/provider.dart';

class Lanes extends StatelessWidget {
  const Lanes({
    super.key,
    required this.swimmersByLane,
    this.latestFinishers,
  }) : numOfLanes = swimmersByLane.length - 1;

  final List<List<Swimmer>> swimmersByLane;
  final List<Swimmer?>? latestFinishers;
  final int numOfLanes;

  List<Widget> get _topRow {
    return [
      for (var i = 1; i <= (numOfLanes / 2).ceil(); i += 1)
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Lane(
                swimmers: swimmersByLane[i],
                laneNum: i,
                latestFinisher: latestFinishers?[i]),
          ),
        )
    ];
  }

  List<Widget> get _bottomRow {
    return [
      for (var i = (numOfLanes / 2).ceil() + 1; i <= numOfLanes; i += 1)
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Lane(
                swimmers: swimmersByLane[i],
                laneNum: i,
                latestFinisher: latestFinishers?[i]),
          ),
        )
    ];
  }

  List<Widget> get _singleRow {
    return [
      for (var i = 1; i < this.numOfLanes; i += 1)
        Expanded(
          child: Lane(
              swimmers: swimmersByLane[i],
              laneNum: i,
              latestFinisher: latestFinishers?[i]),
        )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (this.numOfLanes < 3)
          Expanded(
            child: Row(
              children: _singleRow,
              crossAxisAlignment: CrossAxisAlignment.stretch,
            ),
          ),
        if (this.numOfLanes > 3)
          Expanded(
            child: Row(
              children: _topRow,
              crossAxisAlignment: CrossAxisAlignment.stretch,
            ),
          ),
        if (this.numOfLanes > 3)
          Expanded(
            child: Row(
              children: _bottomRow,
              crossAxisAlignment: CrossAxisAlignment.stretch,
            ),
          )
      ],
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
        color: Theme.of(context).primaryColor,
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
