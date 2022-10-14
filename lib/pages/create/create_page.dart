import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:go_router/go_router.dart';
import "package:swim_timer/entities/swimmer.dart";
import "package:swim_timer/entities/practice.dart";
import 'package:swim_timer/managers/database_manager.dart';

class CreatePage extends StatelessWidget {
  const CreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create"),
        leading: IconButton(
            onPressed: () => {context.go('/')}, icon: Icon(Icons.chevron_left)),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () => {handleCreate(context)},
            child: Text('Create Practice')),
      ),
    );
  }

  void handleCreate(BuildContext context) async { //This is just being used for testing purposes lol
    Practice practice = await DatabaseManager.getPractice("Practice1");
    print(practice.date);
    context.go('/');
  }
}
