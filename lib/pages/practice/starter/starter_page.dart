import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_repository/practice_repository.dart';
import 'package:swim_timer/pages/practice/starter/starter_bloc/starter_bloc.dart';
import 'package:swim_timer/pages/practice/starter/widgets/deck.dart';
import 'package:swim_timer/pages/practice/starter/widgets/icon_action_button.dart';
import 'package:swim_timer/pages/practice/starter/widgets/block_lineup.dart';
import 'package:go_router/go_router.dart';

class StarterPage extends StatelessWidget {
  const StarterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StarterBloc>(
      create: (context) =>
          StarterBloc(practiceRepository: context.read<PracticeRepository>())
            ..add(SubscriptionRequested()),
      child: const StarterView(),
    );
  }
}

class StarterView extends StatelessWidget {
  const StarterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<StarterBloc, StarterState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) {
              if (state.status == StarterStatus.failure) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                      SnackBar(content: Text("Failure Status in StarterBloc")));
              }
            },
          )
        ],
        child: BlocBuilder<StarterBloc, StarterState>(
          builder: ((context, state) {
            if (state.status == StarterStatus.loading) {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            } else {
              return GestureDetector(
                onTap: () => context.read<StarterBloc>().add(TapAway()),
                child: Container(
                  color: Theme.of(context).backgroundColor,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Center(
                          child: BlockLineup(
                            blockSwimmersByLane: state.blockSwimmersByLane,
                            selectedSwimmer: state.selectedSwimmer,
                            // key: ObjectKey(DateTime.now()),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Deck(
                          swimmersOnDeck: state.deckSwimmers,
                          activeSwimmer: state.selectedSwimmer,
                        ),
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(minHeight: 100),
                        child: Center(
                            child: ButtonBar(
                          alignment: MainAxisAlignment.center,
                          children: [
                            IconActionButton(
                                onPressed: () {
                                  // context.go('/add');
                                  String baseAddress = context.read<String>();
                                  context.go(baseAddress + 'add');

                                  //context.read<StarterBloc>().add(TapAdd())
                                },
                                icon: Icon(Icons.add),
                                isSelected: false),
                            IconActionButton(
                              onPressed: () => context
                                  .read<StarterBloc>()
                                  .add(TapAction(action: SelectedAction.edit)),
                              icon: Icon(Icons.edit),
                              isSelected:
                                  state.selectedAction == SelectedAction.edit,
                            ),
                            IconStartButton(
                              canUndoStart: state.canUndoStart,
                              onStart: () => {
                                context
                                    .read<StarterBloc>()
                                    .add(TapStart(DateTime.now()))
                              },
                              onUndo: () =>
                                  {context.read<StarterBloc>().add(TapUndo())},
                            ),
                            IconActionButton(
                              onPressed: () => context.read<StarterBloc>().add(
                                  TapAction(action: SelectedAction.deblock)),
                              icon:
                                  Icon(Icons.indeterminate_check_box_outlined),
                              isSelected: state.selectedAction ==
                                  SelectedAction.deblock,
                            ),
                            IconActionButton(
                              onPressed: () => context.read<StarterBloc>().add(
                                  TapAction(action: SelectedAction.delete)),
                              icon: Icon(Icons.close),
                              isSelected:
                                  state.selectedAction == SelectedAction.delete,
                            )
                          ],
                        )),
                      )
                    ],
                  ),
                ),
              );
            }
          }),
        ),
      ),
    );
  }
}
