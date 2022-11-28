import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_repository/practice_repository.dart';
import 'package:swim_timer/custom_colors.dart';
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
        body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFC7EDFF), Color(0xFF62CFF9), Color(0xFFAAF6FF)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: BlocBuilder<OverviewBloc, OverviewState>(
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
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: EntriesCard(entries: state.entries ?? []),
                  ),
                  flex: 6,
                ),
                Expanded(
                  flex: 1,
                  child: state.filterWithId == null
                      ? StrokeFilterBar()
                      : Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: CustomColors.primaryRed),
                              onPressed: () => context
                                  .read<OverviewBloc>()
                                  .add(SwimmerSelected(idOfSwimmer: null)),
                              child: Text("Show all swimmers")),
                        ),
                ),
              ],
            );
          }
        }),
      ),
    ));
  }
}
