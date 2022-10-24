import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swim_timer/pages/create/create_bloc/create_bloc.dart';
import 'package:provider/provider.dart';
import 'package:swim_timer/pages/create/create_bloc/create_event.dart';
import 'package:swim_timer/pages/create/create_bloc/create_state.dart';
import 'package:go_router/go_router.dart';
import 'package:swim_timer/pages/create/widgets/counter_bar.dart';

class LaneSettingsView extends StatefulWidget {
  const LaneSettingsView({super.key});

  @override
  State<LaneSettingsView> createState() => _LaneSettingsViewState();
}

class _LaneSettingsViewState extends State<LaneSettingsView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final CurvedAnimation _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    // _controller.forward();

    Future.delayed(Duration(milliseconds: 500))
        .then((value) => _controller.forward());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,

      // App Bar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Create',
            //TODO Replace with real color
            style: TextStyle(color: Color.fromARGB(255, 12, 87, 148))),
        centerTitle: true,
        leading: IconButton(
            onPressed: () async {
              await _controller.reverse();
              context.go('/');
            },
            icon: const Icon(
              Icons.chevron_left,
              color: Colors.black,
            )),
      ),

      // Floating Action Buttons
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FloatingActionButton(
                heroTag: null,
                onPressed: () async {
                  await _controller.reverse();
                  context
                      .read<CreateBloc>()
                      .add(CreateEvent_SetStep(step: CreateStep.name));
                },
                child: const Icon(Icons.forward,
                    size: 50, textDirection: TextDirection.rtl),
              ),
              FloatingActionButton(
                  heroTag: null,
                  onPressed: () {
                    context.go("/practice/fromCreate${Random().nextInt(25)}");
                  },
                  child: const Icon(Icons.check, size: 50)),
            ],
          )),
      // Body
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 156,
          ),
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Lane Count:',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 25,
                ),
                CounterBar(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
