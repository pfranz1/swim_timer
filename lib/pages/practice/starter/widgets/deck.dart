import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_repository/practice_repository.dart';
import 'package:swim_timer/pages/practice/starter/starter_bloc/starter_bloc.dart';

class Deck extends StatelessWidget {
  const Deck(
      {super.key, required this.swimmersOnDeck, required this.activeSwimmer});

  final List<Swimmer> swimmersOnDeck;
  final Swimmer? activeSwimmer;

  final Map<Stroke, Color> colors = const {
    Stroke.FREE_STYLE: Colors.green,
    Stroke.BACK_STROKE: Colors.blue,
    Stroke.BREAST_STROKE: Colors.red,
    Stroke.BUTTERFLY: Colors.purple
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: AspectRatio(
        aspectRatio: 3 / 2,
        child: GridView.builder(
          itemCount: this.swimmersOnDeck.length,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 125.0,
              crossAxisSpacing: 5.0,
              mainAxisSpacing: 5.0),
          itemBuilder: (context, index) {
            return ElevatedButton(
              key: ObjectKey(swimmersOnDeck[index]),
              style: ElevatedButton.styleFrom(
                  alignment: Alignment.center,
                  backgroundColor: colors[swimmersOnDeck[index].stroke],
                  side: BorderSide(
                      color: Colors.black,
                      width:
                          swimmersOnDeck[index] == activeSwimmer ? 5.0 : 2.0)),
              onPressed: () => context
                  .read<StarterBloc>()
                  .add(TapSwimmer(swimmersOnDeck[index], false)),
              child: Text("${swimmersOnDeck[index].name}"),
            );
          },
        ),
      ),
    );
  }
}
