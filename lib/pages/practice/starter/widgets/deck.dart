import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:practice_repository/practice_repository.dart';

class Deck extends StatelessWidget {
  const Deck({super.key, required this.swimmersOnDeck});

  final List<Swimmer> swimmersOnDeck;

  final Map<Stroke, Color> colors = const {
    Stroke.FREE_STYLE: Colors.green,
    Stroke.BACK_STROKE: Colors.blue,
    Stroke.BREAST_STROKE: Colors.red,
    Stroke.BUTTERFLY: Colors.purple
  };

  @override
  Widget build(BuildContext context) {
    return CupertinoScrollbar(
      child: GridView.builder(
        itemCount: this.swimmersOnDeck.length,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 125.0,
            crossAxisSpacing: 5.0,
            mainAxisSpacing: 5.0),
        itemBuilder: (context, index) {
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
                alignment: Alignment.center,
                backgroundColor: colors[swimmersOnDeck[index].stroke]),
            onPressed: () => print("poke"),
            child: Text("${swimmersOnDeck[index].name}"),
          );
        },
      ),
    );
  }
}
