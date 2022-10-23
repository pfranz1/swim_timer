import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swim_timer/main.dart';
import 'package:swim_timer/pages/create/create_bloc/create_bloc.dart';
import 'package:provider/provider.dart';
import 'package:swim_timer/pages/create/create_bloc/create_event.dart';
import 'package:swim_timer/pages/create/create_bloc/create_state.dart';
import 'package:go_router/go_router.dart';

class NameView extends StatefulWidget {
  NameView({super.key}) : nameController = TextEditingController();

  final TextEditingController nameController;

  @override
  State<NameView> createState() => _NameViewState();
}

class _NameViewState extends State<NameView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final CurvedAnimation _curvedAnimation;

  static const _delayForNavigationTransitionTime = Duration(milliseconds: 250);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _curvedAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(_controller);

    Future.delayed(_delayForNavigationTransitionTime)
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
      floatingActionButton: FloatingActionButton(
        onPressed: (() async {
          await _controller.reverse();
          context
              .read<CreateBloc>()
              .add(CreateEvent_SetStep(step: CreateStep.laneSettings));
        }),
        child: Icon(
          Icons.forward,
          size: 50,
        ),
      ),
      body: FadeTransition(
        opacity: _curvedAnimation,
        child: Center(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 156),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Practice Name:',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 25,
                ),
                TextField(
                  textAlign: TextAlign.center,
                  controller: widget.nameController,
                  style: TextStyle(),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      filled: true,
                      hintStyle: TextStyle(color: Colors.grey[800]),
                      hintText: "Practice Name",
                      fillColor: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
