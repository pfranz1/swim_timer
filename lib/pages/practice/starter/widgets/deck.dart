import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_repository/practice_repository.dart';
import 'package:swim_timer/pages/practice/starter/starter_bloc/starter_bloc.dart';
import 'package:swim_timer/pages/practice/starter/widgets/swimmer_tile.dart';

class Deck extends StatelessWidget {
  const Deck(
      {super.key, required this.swimmersOnDeck, required this.activeSwimmer});

  final List<Swimmer> swimmersOnDeck;
  final Swimmer? activeSwimmer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16.0)),
            color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            itemCount: swimmersOnDeck.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:
                    max(3, (MediaQuery.of(context).size.width / 150).floor()),
                childAspectRatio: 1,
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 5.0),
            itemBuilder: (context, index) {
              return SwimmerTile(
                  swimmer: swimmersOnDeck[index],
                  isActiveSwimmer: swimmersOnDeck[index] == activeSwimmer,
                  isOnBlock: false,
                  onTap: () => context
                      .read<StarterBloc>()
                      .add(TapSwimmer(swimmersOnDeck[index], false)));
            },
          ),
        ),
      ),
    );
  }
}
