import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:go_router/go_router.dart';
import 'dart:math';

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
        child:
            ElevatedButton(onPressed: () => {this.handleCreate()}, child: Text('Create Practice')),
      ),
    );
  }

  void handleCreate()
  {
    int randomNum = Random.secure().nextInt(1000);
    DatabaseReference dbRef = FirebaseDatabase.instance.reference().child("TestUser");
    dbRef..child("Practice ${randomNum}").set("Practice ${randomNum}");
  }
}
