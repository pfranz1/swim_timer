import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practice_repository/practice_repository.dart';
import 'package:provider/provider.dart';
import 'package:swim_timer/pages/practice/starter/starter_bloc/starter_bloc.dart';

class SwimmerTile extends StatelessWidget {
  // TODO: Centeralize this color information
  final Map<Stroke, Color> colors = const {
    Stroke.FREE_STYLE: Colors.green,
    Stroke.BACK_STROKE: Colors.red,
    Stroke.BREAST_STROKE: Colors.orange,
    Stroke.BUTTERFLY: Colors.lightBlue
  };

  const SwimmerTile({
    Key? key,
    required this.swimmer,
    required this.isActiveSwimmer,
    required this.isOnBlock,
    this.onTap,
  }) : super(key: key);

  final Swimmer swimmer;
  final bool isActiveSwimmer;
  final bool isOnBlock;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: ObjectKey(swimmer.id),
      style: ElevatedButton.styleFrom(
          alignment: Alignment.center,
          backgroundColor: colors[swimmer.stroke],
          side: BorderSide(
              color: Colors.black, width: isActiveSwimmer ? 5.0 : 2.0)),
      onPressed: onTap,
      // context.read<StarterBloc>().add(TapSwimmer(swimmer, isOnBlock)),
      child: Text(swimmer.name),
    );
  }
}
