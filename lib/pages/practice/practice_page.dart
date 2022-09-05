import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swim_timer/pages/practice/practice_cubit/practice_cubit.dart';
import 'package:swim_timer/pages/practice/starter/starter_page.dart';
import 'package:swim_timer/pages/practice/stopper/stopper_page.dart';

class PracticePage extends StatelessWidget {
  const PracticePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PracticeCubit(),
      child: const PracticeView(),
    );
  }
}

class PracticeView extends StatelessWidget {
  const PracticeView({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTab =
        context.select((PracticeCubit cubit) => cubit.state.tab);

    return Scaffold(
      body: IndexedStack(
        index: selectedTab.index,
        children: const [
          StarterPage(),
          StopperPage(),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _PracticeTabButton(
                groupValue: selectedTab,
                value: PracticeTab.starter,
                icon: Icon(Icons.play_circle_outline_rounded)),
            _PracticeTabButton(
                groupValue: selectedTab,
                value: PracticeTab.stopper,
                icon: Icon(Icons.stop_circle_outlined)),
          ],
        ),
      ),
    );
  }
}

class _PracticeTabButton extends StatelessWidget {
  const _PracticeTabButton({
    required this.groupValue,
    required this.value,
    required this.icon,
  });

  final PracticeTab groupValue;
  final PracticeTab value;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => context.read<PracticeCubit>().setTab(value),
        iconSize: 32,
        color: groupValue != value
            ? null
            : Theme.of(context).colorScheme.secondary,
        icon: icon);
  }
}
