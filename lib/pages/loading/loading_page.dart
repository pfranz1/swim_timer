import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

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
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
