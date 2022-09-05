import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_repository/practice_repository.dart';
import 'package:swim_timer/pages/practice/starter/starter_bloc/starter_bloc.dart';
import 'package:swim_timer/pages/practice/starter/widgets/deck.dart';
import 'package:swim_timer/pages/practice/starter/widgets/lane.dart';

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
                onTap: () =>
                    context.read<StarterBloc>().add(TapSwimmer(null, false)),
                child: Container(
                  color: Theme.of(context).backgroundColor,
                  child: Column(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Center(
                            child: Text('Starter'),
                          )),
                      Expanded(
                        flex: 4,
                        child: Center(
                          child:
                              BlockLineup(blockSwimmers: state.blockSwimmers),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Center(
                          child: Deck(
                            swimmersOnDeck: state.deckSwimmers,
                            activeSwimmer: state.selectedSwimmer,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Center(
                            child: ButtonBar(
                          alignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () =>
                                    {context.read<StarterBloc>().add(TapAdd())},
                                icon: Icon(Icons.add)),
                            IconButton(
                                onPressed: () => {
                                      context
                                          .read<StarterBloc>()
                                          .add(TapStart(DateTime.now()))
                                    },
                                icon: Icon(Icons.play_arrow_rounded)),
                            IconButton(
                                onPressed: () => print('Edit'),
                                icon: Icon(Icons.edit))
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
