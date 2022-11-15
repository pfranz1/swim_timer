import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practice_repository/practice_repository.dart';
import 'package:provider/provider.dart';
import 'package:swim_timer/pages/practice/starter/starter_bloc/starter_bloc.dart';
import 'package:entities/entities.dart';

class SwimmerTile extends StatelessWidget {
  // TODO: Centeralize this color information
  final Map<Stroke, Color> colors = const {
    Stroke.FREE_STYLE: Color(0xFF62CA50),
    Stroke.BACK_STROKE: Color(0xFFD42A34),
    Stroke.BREAST_STROKE: Color(0xFFF78C37),
    Stroke.BUTTERFLY: Color(0xFF0677BA)
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
              color: isActiveSwimmer ? Colors.black : Colors.transparent,
              width: 5.0)),
      onPressed: onTap,
      // context.read<StarterBloc>().add(TapSwimmer(swimmer, isOnBlock)),
      child: FittedBox(
        fit: BoxFit.fitHeight,
        child: Text(
          swimmer.name.replaceAll(" ", "\n"),
          style: TextStyle(fontSize: 100, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
