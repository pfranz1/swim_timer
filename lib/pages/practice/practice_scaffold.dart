import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:go_router/go_router.dart';
import 'package:swim_timer/pages/practice/practice_cubit/practice_cubit.dart';
import 'package:provider/provider.dart';

enum PracticeTab { starter, stopper, overview }

class PracticeScaffold extends StatelessWidget {
  PracticeScaffold({super.key, required this.child, required this.location}) {
    print("build practice scaffold");
  }

  final Widget child;

  final String location;

  String _popAndReplace(String replacement) {
    return _baseAddress + replacement;
  }

  String get _baseAddress {
    return location.substring(0, location.lastIndexOf("/") + 1);
  }

  PracticeTab get selectedTab {
    switch (currentLocation) {
      case "Starter":
        return PracticeTab.starter;
      case "Stopper":
        return PracticeTab.stopper;

      case "Overview":
        return PracticeTab.overview;

      default:
        return PracticeTab.starter;
    }
  }

  int get indexOfTab {
    switch (selectedTab) {
      case PracticeTab.starter:
        return 0;
      case PracticeTab.stopper:
        return 1;
      case PracticeTab.overview:
        return 2;
    }
  }

  String get currentLocation =>
      upperCase(location.substring(location.lastIndexOf("/") + 1));

  String upperCase(String string) =>
      string.substring(0, 1).toUpperCase() + string.substring(1);

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: _baseAddress,
      child: Scaffold(
        appBar: AppBar(
          title: Text(currentLocation),
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
              onPressed: () => context.go('/'),
              icon: Icon(
                Icons.chevron_left,
                color: Theme.of(context).colorScheme.onBackground,
              )),
        ),
        body: child,
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _PracticeTabButton(
                onPressed: () =>
                    context.go(_popAndReplace("starter"), extra: indexOfTab),
                groupValue: selectedTab,
                value: PracticeTab.starter,
                icon: Icon(Icons.play_circle_outline_rounded),
              ),
              _PracticeTabButton(
                  onPressed: () =>
                      context.go(_popAndReplace("stopper"), extra: indexOfTab),
                  groupValue: selectedTab,
                  value: PracticeTab.stopper,
                  icon: Icon(Icons.stop_circle_outlined)),
              _PracticeTabButton(
                  onPressed: () =>
                      context.go(_popAndReplace("overview"), extra: indexOfTab),
                  groupValue: selectedTab,
                  value: PracticeTab.overview,
                  icon: Icon(Icons.list)),
            ],
          ),
        ),
      ),
    );
  }
}

class _PracticeTabButton extends StatelessWidget {
  const _PracticeTabButton({
    required this.onPressed,
    required this.groupValue,
    required this.value,
    required this.icon,
  });

  final void Function() onPressed;
  final PracticeTab groupValue;
  final PracticeTab value;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onPressed,
        iconSize: 32,
        color: groupValue != value
            ? null
            : Theme.of(context).colorScheme.secondary,
        icon: icon);
  }
}
