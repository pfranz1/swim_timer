import 'package:flutter/animation.dart';
import 'package:entities/entities.dart';
import 'package:flutter/material.dart';

class SwimmerTile extends StatelessWidget {
  //TODO: Move these colors somewhere central
  final Map<Stroke, Color> colors = const {
    Stroke.FREE_STYLE: Color(0xFF62CA50),
    Stroke.BACK_STROKE: Color(0xFFD42A34),
    Stroke.BREAST_STROKE: Color(0xFFF78C37),
    Stroke.BUTTERFLY: Color(0xFF0677BA)
  };

  const SwimmerTile({
    Key? key,
    required this.swimmer,
    this.onTap,
  }) : super(key: key);

  final Swimmer swimmer;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: ObjectKey(swimmer),
      style: ElevatedButton.styleFrom(
          alignment: Alignment.center,
          backgroundColor: colors[swimmer.stroke],
          side: const BorderSide(color: Colors.black, width: 2.0)),
      onPressed: onTap,
      // context.read<StarterBloc>().add(TapSwimmer(swimmer, isOnBlock)),
      child: Text(swimmer.name),
    );
  }
}
