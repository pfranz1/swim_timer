import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:practice_repository/practice_repository.dart';

class BlockLineup extends StatelessWidget {
  const BlockLineup({super.key, required this.blockSwimmers});

  final List<Swimmer> blockSwimmers;

  //TODO: Remove magic number
  static const int numOfLanes = 6;

  static const int numPerRow = 3;

  @override
  Widget build(BuildContext context) {
    final List<Swimmer?> organizedSwimmers = List.filled(numOfLanes, null);

    for (Swimmer swimmer in blockSwimmers) {
      organizedSwimmers[swimmer.lane! - 1] = swimmer;
    }

    return GridView.builder(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: numPerRow),
      itemCount: numOfLanes,
      itemBuilder: ((context, index) {
        return BlockTile(swimmer: organizedSwimmers[index]);
      }),
    );
  }
}

class BlockTile extends StatelessWidget {
  const BlockTile({super.key, required this.swimmer});

  final Swimmer? swimmer;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.lightBlue,
        child: Center(
            child: swimmer != null
                ? Container(
                    child: Text(swimmer!.name),
                  )
                : null));
  }
}
