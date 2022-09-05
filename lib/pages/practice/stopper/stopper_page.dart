import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_repository/practice_repository.dart';
import 'package:swim_timer/pages/practice/stopper/stopper_bloc/stopper_bloc.dart';

class StopperPage extends StatelessWidget {
  const StopperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          StopperBloc(practiceRepository: context.read<PracticeRepository>())
            ..add(SubscriptionRequested()),
      child: const StopperView(),
    );
  }
}

class StopperView extends StatelessWidget {
  const StopperView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: MultiBlocListener(
      listeners: [
        BlocListener<StopperBloc, StopperState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status == StopperStatus.failure) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                    SnackBar(content: Text("Failure Status in StopperBloc")));
            }
          },
        )
      ],
      child: BlocBuilder<StopperBloc, StopperState>(
        builder: ((context, state) {
          if (state.status == StopperStatus.loading) {
            return const Center(child: CupertinoActivityIndicator());
          } else {
            if (state.lanesOfSwimmers.length < 3) {
              return Center(
                child: Text("NOTHING YET"),
              );
            }

            return Center(
                child: Text(state.lanesOfSwimmers.sublist(1).toString()));
          }
        }),
      ),
    ));
  }
}
