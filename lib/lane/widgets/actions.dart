import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:swim_timer/lane/bloc/bloc.dart';

class LaneActions extends StatelessWidget {
  const LaneActions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        OutlinedButton(
            onPressed: () =>
                context.read<LaneBloc>().add(LaneRemove("testSwimmer")),
            child: Text("Remove Swimmer")),
        ElevatedButton(
            onPressed: () =>
                context.read<LaneBloc>().add(LaneAdd("testSwimmer")),
            child: Text("Add Swimmer"))
      ],
    );
  }
}
