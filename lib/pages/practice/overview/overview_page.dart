import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_repository/practice_repository.dart';
import 'package:swim_timer/pages/practice/overview/overview_bloc/overview_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:swim_timer/pages/practice/overview/widgets/entries_card.dart';
import 'package:swim_timer/pages/practice/overview/widgets/stroke_filter_bar.dart';

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
    return Scaffold(
      body: BlocBuilder<OverviewBloc, OverviewState>(
        builder: ((context, state) {
          if (state.status == OverviewStatus.loading) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          } else {
            return Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: EntriesCard(entries: state.entries),
                  ),
                  flex: 4,
                ),
                Expanded(
                  flex: 1,
                  child: StrokeFilterBar(),
                ),
              ],
            );
          }
        }),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
    );
  }
}
