import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:go_router/go_router.dart';
import 'package:swim_timer/custom_colors.dart';
import 'package:swim_timer/pages/practice/flag_line.dart';
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

  List<Color> get flagColors {
    switch (indexOfTab) {
      case 0:
        return [CustomColors.freeStyle, CustomColors.primeColor];
      case 1:
        return [CustomColors.backStroke, CustomColors.primeColor];
      case 2:
        return [CustomColors.butterfly, CustomColors.primeColor];
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: _baseAddress,
      child: Scaffold(
        appBar: AppBar(
          title: Column(
            children: [
              Text(
                currentLocation,
                style: TextStyle(
                  color: CustomColors.primeColor,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (selectedTab != PracticeTab.overview)
                FlagLine(
                  colors: flagColors,
                ),
            ],
          ),
          backgroundColor: Color(0xFFC7EDFF),
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
              onPressed: () => context.go('/'),
              icon: Icon(
                Icons.chevron_left,
                color: Colors.black,
              )),
        ),
        extendBodyBehindAppBar: false,
        body: child,
        bottomNavigationBar: BottomAppBar(
          color: CustomColors.primeColor,
          shape: const CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _PracticeTabButton(
                onPressed: () =>
                    context.go(_popAndReplace("starter"), extra: indexOfTab),
                groupValue: selectedTab,
                value: PracticeTab.starter,
                assetPath: "assets/images/whistle_icon.png",
              ),
              _PracticeTabButton(
                onPressed: () =>
                    context.go(_popAndReplace("stopper"), extra: indexOfTab),
                groupValue: selectedTab,
                value: PracticeTab.stopper,
                assetPath: "assets/images/stop_watch_icon.png",
              ),
              _PracticeTabButton(
                  onPressed: () =>
                      context.go(_popAndReplace("overview"), extra: indexOfTab),
                  groupValue: selectedTab,
                  value: PracticeTab.overview,
                  icon: Icon(Icons.bar_chart)),
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
    this.icon,
    this.assetPath,
  });

  final void Function() onPressed;
  final PracticeTab groupValue;
  final PracticeTab value;
  final Widget? icon;
  final String? assetPath;

  static const Color _color = Color(0xFF58CDFF);

  @override
  Widget build(BuildContext context) {
    // Should pass at least one, will use the asset if both provided
    assert(icon != null || assetPath != null);

    Widget? iconReplacement = null;

    if (assetPath != null) {
      iconReplacement = Image.asset(
        assetPath!,
        color: groupValue != value ? _color.withOpacity(0.25) : _color,
      );
    }

    return IconButton(
        onPressed: onPressed,
        iconSize: 48,
        color: groupValue != value ? _color.withOpacity(0.25) : _color,
        icon: iconReplacement ?? icon!);
  }
}
