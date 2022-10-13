import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:swim_timer/main.dart';
import 'package:go_router/go_router.dart';

class AddSwimmerPage extends StatelessWidget {
  const AddSwimmerPage({super.key, required this.backLocation});

  final String backLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Swimmer"),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              context.go(backLocation);
            },
            icon: Icon(
              Icons.chevron_left,
              color: Theme.of(context).colorScheme.onBackground,
            )),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(child: Text("Add Swimmer")),
    );
  }
}
