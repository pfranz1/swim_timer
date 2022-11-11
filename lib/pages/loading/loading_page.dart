import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:go_router/go_router.dart';
import 'package:swim_timer/custom_colors.dart';

/// As soon as this screen can it will call the provided function
/// That function should probably have the size effect of navigating the user
/// away from this screen
class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key, required this.afterLoadingDisplay});

  final void Function(BuildContext context) afterLoadingDisplay;

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => widget.afterLoadingDisplay(context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        // appBar: AppBar(
        //   title: Text("Loading..."),
        //   centerTitle: true,
        //   leading: IconButton(
        //     icon: Icon(Icons.chevron_left),
        //     onPressed: () => context.go('/'),
        //   ),
        // ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFE6F3F9), Color(0xFFC6E3EE), Color(0xFFAAF6FF)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: CustomColors.primeColor,
                ),
                child: const Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: CircularProgressIndicator(
                    color: Color(0xFF77D6FF),
                  ),
                )),
          ),
        ));
  }
}
