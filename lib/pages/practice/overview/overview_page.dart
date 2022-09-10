import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_repository/practice_repository.dart';
import 'package:swim_timer/pages/practice/overview/overview_bloc/overview_bloc.dart';

class OverviewPage extends StatelessWidget {
  const OverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          OverviewBloc(praticeRepository: context.read<PracticeRepository>())
            ..add(SubscriptionRequested()),
      child: const OverviewView(),
    );
  }
}

class OverviewView extends StatelessWidget {
  const OverviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<OverviewBloc, OverviewState>(
      builder: ((context, state) {
        if (state.status == OverviewStatus.loading) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        } else {
          return Center(
              child: ListView.builder(
            itemBuilder: (context, index) {
              return Card(
                child: Text('${state.entries?[index]}'),
              );
            },
            itemCount: state.entries?.length ?? 0,
          ));
        }
      }),
    ));
  }
}
