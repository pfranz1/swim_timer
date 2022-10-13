import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:practice_repository/practice_repository.dart';
import 'package:swim_timer/pages/practice/starter/starter_bloc/starter_bloc.dart';
import 'package:swim_timer/pages/practice/starter/widgets/swimmer_tile.dart';

class BlockLineup extends StatelessWidget {
  const BlockLineup(
      {super.key,
      required this.blockSwimmersByLane,
      required this.selectedSwimmer})
      : numOfLanes = blockSwimmersByLane.length - 1;

  final List<List<Swimmer>> blockSwimmersByLane;
  final Swimmer? selectedSwimmer;

  final int numOfLanes;

  List<Widget> get _topRow {
    return [
      for (var i = 1; i <= (numOfLanes / 2).ceil(); i += 1)
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlockTile(
            laneNumber: i,
            swimmer: this.blockSwimmersByLane[i].isEmpty
                ? null
                : this.blockSwimmersByLane[i].first,
            isSwimmerSelected: i == this.selectedSwimmer?.lane,
          ),
        ))
    ];
  }

  List<Widget> get _bottomRow {
    return [
      for (var i = (numOfLanes / 2).ceil() + 1; i <= numOfLanes; i += 1)
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlockTile(
            laneNumber: i,
            swimmer: this.blockSwimmersByLane[i].isEmpty
                ? null
                : this.blockSwimmersByLane[i].first,
            isSwimmerSelected: i == this.selectedSwimmer?.lane,
          ),
        ))
    ];
  }

  List<Widget> get _singleRow {
    return [
      for (var i = 1; i < this.numOfLanes; i += 1)
        Expanded(
          child: BlockTile(
            laneNumber: i,
            swimmer: this.blockSwimmersByLane[i].isEmpty
                ? null
                : this.blockSwimmersByLane[i].first,
            isSwimmerSelected: i == this.selectedSwimmer?.lane,
          ),
        )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (this.numOfLanes <= 3)
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
      ),
    );
  }
}

class BlockTile extends StatelessWidget {
  const BlockTile({
    super.key,
    required this.swimmer,
    required this.laneNumber,
    this.isSwimmerSelected = false,
  });

  final Swimmer? swimmer;
  final int laneNumber;
  final bool isSwimmerSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          context.read<StarterBloc>().add(TapLane(laneNumber, swimmer)),
      child: Container(
          color: Colors.lightBlue,
          child: Center(
              child: swimmer != null
                  ? SwimmerTile(
                      swimmer: swimmer!,
                      isActiveSwimmer: isSwimmerSelected,
                      isOnBlock: true,
                      onTap: () => context
                          .read<StarterBloc>()
                          .add(TapLane(laneNumber, swimmer)),
                    )
                  : null)),
    );
  }
}
