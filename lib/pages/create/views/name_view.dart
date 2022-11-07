import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swim_timer/CustomColors.dart';
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
  late final CurvedAnimation _fadeAnimation;

  static const _delayForNavigationTransitionTime = Duration(milliseconds: 250);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
      reverseDuration: const Duration(milliseconds: 425),
    );

    _fadeAnimation = CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutCirc,
        reverseCurve: Curves.ease);

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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Create',
          style: TextStyle(
            fontSize: 20,
            color: CustomColors.primeColor,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
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
        backgroundColor: const Color(0xFF10465F),
        child: const Icon(
          Icons.arrow_forward_outlined,
          size: 50,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE6F3F9), Color(0xFFC6E3EE), Color(0xFFAAF6FF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: FadeTransition(
          opacity: _fadeAnimation,
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
                    style: TextStyle(
                      fontSize: 20,
                      color: CustomColors.primeColor,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                        maxWidth: min(
                            500, MediaQuery.of(context).size.width * 3 / 4)),
                    child: TextField(
                      textAlign: TextAlign.center,
                      controller: widget.nameController,
                      autofocus: true,
                      style: TextStyle(
                        fontSize: 15,
                        color: CustomColors.primeColor,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                      onSubmitted: (value) async {
                        await _controller.reverse();
                        context.read<CreateBloc>().add(
                            CreateEvent_SetStep(step: CreateStep.laneSettings));
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          filled: true,
                          hintStyle: TextStyle(color: Colors.grey[800]),
                          fillColor: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
