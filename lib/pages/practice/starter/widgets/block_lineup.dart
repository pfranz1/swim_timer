import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:practice_repository/practice_repository.dart';
import 'package:swim_timer/pages/practice/starter/starter_bloc/starter_bloc.dart';
import 'package:swim_timer/pages/practice/starter/widgets/swimmer_tile.dart';
import 'package:entities/entities.dart';

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
          color: Color(0xFFE1FCFF),
          child: LayoutBuilder(builder: (context, constraints) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 6.0, right: 6.0),
                  child: Text(laneNumber.toString(),
                      style: const TextStyle(
                          fontFamily: 'working sans',
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54)),
                ),
                if (swimmer != null)
                  SwimmerCard(
                    height: constraints.maxHeight * 0.66,
                    swimmer: swimmer!,
                    isSelected: isSwimmerSelected,
                  )
              ],
            );
          })

          // Center(
          //     child: swimmer != null
          //         ? SwimmerTile(
          //             swimmer: swimmer!,
          //             isActiveSwimmer: isSwimmerSelected,
          //             isOnBlock: true,
          //             onTap: () => context
          //                 .read<StarterBloc>()
          //                 .add(TapLane(laneNumber, swimmer)),
          //           )
          //         : null)

          ),
    );
  }
}

class SwimmerCard extends StatelessWidget {
  const SwimmerCard({
    Key? key,
    required this.height,
    required this.swimmer,
    required this.isSelected,
  }) : super(key: key);

  final double height;
  final Swimmer swimmer;
  final bool isSelected;

  // TODO: Centeralize this color information
  final Map<Stroke, Color> stokeColors = const {
    Stroke.FREE_STYLE: Color(0xFF62CA50),
    Stroke.BACK_STROKE: Color(0xFFD42A34),
    Stroke.BREAST_STROKE: Color(0xFFF78C37),
    Stroke.BUTTERFLY: Color(0xFF0677BA)
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: stokeColors[swimmer.stroke],
          border: Border.all(
              color: isSelected ? Colors.black : Colors.white, width: 5.0)),
      height: height,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              swimmer.name.replaceAll(" ", "\n"),
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  fontSize: 16,
                  overflow: TextOverflow.fade),
            ),
          )
        ],
      ),
    );
  }
}
