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
  BlockLineup(
      {super.key,
      required this.blockSwimmersByLane,
      required this.selectedSwimmer})
      : numOfLanes = blockSwimmersByLane.length - 1;

  final List<List<Swimmer>> blockSwimmersByLane;
  final Swimmer? selectedSwimmer;

  final int numOfLanes;

  static const spacingBetweenBlocks = 8.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
        child: LayoutBuilder(builder: (context, constraints) {
          final numOfRows = (numOfLanes / 3);

          final availableWidth =
              constraints.maxWidth - (spacingBetweenBlocks * 2);

          final availableHeight =
              constraints.maxHeight - (numOfRows * spacingBetweenBlocks);

          var aspectRatio =
              (availableWidth / 3) / (availableHeight / numOfRows);
          return Center(
              child: numOfLanes > 0
                  ? GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: spacingBetweenBlocks,
                        crossAxisSpacing: spacingBetweenBlocks,
                        crossAxisCount: 3,
                        childAspectRatio: aspectRatio,
                      ),
                      itemCount: numOfLanes,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        index = index + 1;
                        return BlockTile(
                          laneNumber: index,
                          swimmer: blockSwimmersByLane[index].isEmpty
                              ? null
                              : blockSwimmersByLane[index].first,
                          isSwimmerSelected: index == selectedSwimmer?.lane,
                        );
                      },
                    )
                  : const CupertinoActivityIndicator());
        }));
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
          decoration: BoxDecoration(
              color: Color(0xFFE1FCFF),
              borderRadius: BorderRadius.all(Radius.circular(6))),
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
                    width: constraints.maxWidth,
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
    required this.width,
    required this.swimmer,
    required this.isSelected,
  }) : super(key: key);

  final double height;
  final double width;
  final Swimmer swimmer;
  final bool isSelected;

  // TODO: Centeralize this color information
  final Map<Stroke, Color> stokeColors = const {
    Stroke.FREE_STYLE: Color(0xFF62CA50),
    Stroke.BACK_STROKE: Color(0xFFD42A34),
    Stroke.BREAST_STROKE: Color(0xFFF78C37),
    Stroke.BUTTERFLY: Color(0xFF0677BA)
  };

  //TODO: Centralize this information
  final Map<Stroke, String> strokeIconPaths = const {
    Stroke.FREE_STYLE: "assets/images/freestyle_w.png",
    Stroke.BACK_STROKE: "assets/images/backstroke_w.png",
    Stroke.BREAST_STROKE: "assets/images/breaststroke_w.png",
    Stroke.BUTTERFLY: "assets/images/butterfly_w.png",
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: stokeColors[swimmer.stroke],
          borderRadius: BorderRadius.all(Radius.circular(6.0)),
          border: Border.all(
              color: isSelected ? Colors.black : Colors.transparent,
              width: 5.0)),
      height: height,
      width: double.infinity,
      child: (height / width > (1 / 2))
          ? StackedNameAndStroke(
              swimmerName: swimmer.name,
              isSelected: isSelected,
              iconAssetPath: strokeIconPaths[swimmer.stroke]!,
            )
          : PairedNameAndStroke(
              swimmerName: swimmer.name,
              isSelected: isSelected,
              iconAssetPath: strokeIconPaths[swimmer.stroke]!,
            ),
    );
  }
}

class StackedNameAndStroke extends StatelessWidget {
  const StackedNameAndStroke({
    Key? key,
    required this.swimmerName,
    required this.iconAssetPath,
    required this.isSelected,
  }) : super(key: key);

  final String swimmerName;
  final String iconAssetPath;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                swimmerName,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    fontSize: 20,
                    overflow: TextOverflow.fade),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            flex: 2,
            child: Image(
              image: AssetImage(iconAssetPath),
              fit: BoxFit.scaleDown,
            ),
          ),
        ],
      ),
    );
  }
}

class PairedNameAndStroke extends StatelessWidget {
  const PairedNameAndStroke({
    Key? key,
    required this.swimmerName,
    required this.iconAssetPath,
    required this.isSelected,
  }) : super(key: key);

  final String swimmerName;
  final String iconAssetPath;

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 4,
            child: FittedBox(
              fit: BoxFit.contain,
              clipBehavior: Clip.hardEdge,
              child: Text(
                swimmerName,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    fontSize: 20,
                    overflow: TextOverflow.fade),
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            flex: 2,
            child: Image(
              image: AssetImage(iconAssetPath),
              fit: BoxFit.fitHeight,
            ),
          ),
        ],
      ),
    );
  }
}
