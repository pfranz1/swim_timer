import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:practice_repository/practice_repository.dart';
import 'package:swim_timer/pages/practice/starter/starter_bloc/starter_bloc.dart';
import 'package:swim_timer/pages/practice/starter/widgets/swimmer_tile.dart';

class BlockLineup extends StatelessWidget {
  const BlockLineup({super.key, required this.blockSwimmers});

  final List<Swimmer> blockSwimmers;

  //TODO: Remove magic number
  static const int numOfLanes = 6;

  static const int numPerRow = 2;

  @override
  Widget build(BuildContext context) {
    final List<Swimmer?> organizedSwimmers = List.filled(numOfLanes, null);

    for (Swimmer swimmer in blockSwimmers) {
      organizedSwimmers[swimmer.lane! - 1] = swimmer;
    }

    return Container(
      padding: EdgeInsets.all(10),
      child: AspectRatio(
        aspectRatio: 3 / 2,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, mainAxisSpacing: 10, crossAxisSpacing: 10),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: numOfLanes,
          itemBuilder: ((context, index) {
            return BlockTile(
              swimmer: organizedSwimmers[index],
              laneNumber: index + 1,
            );
          }),
        ),
      ),
    );
  }
}

class BlockTile extends StatelessWidget {
  const BlockTile({super.key, required this.swimmer, required this.laneNumber});

  final Swimmer? swimmer;
  final int laneNumber;

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
                      isActiveSwimmer: false,
                      isOnBlock: true,
                      onTap: () => context
                          .read<StarterBloc>()
                          .add(TapLane(laneNumber, swimmer)),
                    )
                  : null)),
    );
  }
}
