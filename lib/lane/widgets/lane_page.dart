import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swim_timer/lane/bloc/lane_bloc.dart';
import 'package:swim_timer/lane/widgets/actions.dart';
import 'package:swim_timer/lane/widgets/swimmer_list.dart';

class LanePage extends StatelessWidget {
  const LanePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LaneBloc(),
      child: LaneView(),
    );
  }
}

class LaneView extends StatelessWidget {
  const LaneView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Expanded(child: SwimmerList(), flex: 7),
        Expanded(child: LaneActions(), flex: 3),
      ],
    );
  }
}
