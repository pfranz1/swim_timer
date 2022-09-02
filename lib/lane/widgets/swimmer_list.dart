import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swim_timer/lane/bloc/bloc.dart';
// import 'package:swim_timer/lane/bloc/bloc.dart';

class SwimmerList extends StatefulWidget {
  const SwimmerList({Key? key}) : super(key: key);

  @override
  State<SwimmerList> createState() => _SwimmerListState();
}

class _SwimmerListState extends State<SwimmerList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LaneBloc, LaneState>(builder: (context, state) {
      if (state.swimmers.isEmpty) {
        return const Center(
          child: Text("No Swimmers"),
        );
      } else {
        return ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Text(state.swimmers.elementAt(index)),
            );
          },
          itemCount: state.swimmers.length,
        );
      }
    });
  }
}

/// LANE BLOC


