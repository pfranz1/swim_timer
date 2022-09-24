import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:swim_timer/main.dart';

class AddSwimmer extends StatelessWidget {
  const AddSwimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Swimmer"),
        centerTitle: true,
      ),
    );
  }
}
