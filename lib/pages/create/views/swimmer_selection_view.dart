import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swim_timer/pages/create/create_bloc/create_bloc.dart';
import 'package:provider/provider.dart';
import 'package:swim_timer/pages/create/create_bloc/create_event.dart';
import 'package:swim_timer/pages/create/create_bloc/create_state.dart';

class SwimmerSelectionView extends StatefulWidget {
  const SwimmerSelectionView({super.key});

  @override
  State<SwimmerSelectionView> createState() => _SwimmerSelectionViewState();
}

class _SwimmerSelectionViewState extends State<SwimmerSelectionView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          context
              .read<CreateBloc>()
              .add(CreateEvent_SetStep(step: CreateStep.name));
        }),
      ),
      body: Column(
        children: [
          Text('Swimmers here'),
        ],
      ),
    );
  }
}
