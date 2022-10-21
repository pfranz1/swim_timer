import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:go_router/go_router.dart';

class JoinPage extends StatelessWidget {
  const JoinPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Join"),
        leading: IconButton(
            onPressed: () => {context.go('/')}, icon: Icon(Icons.chevron_left)),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () =>
                    {this.selectionHandler("/practice/1111", context)},
                child: Text('Join Practice 1111')),
            ElevatedButton(
                onPressed: () =>
                    {this.selectionHandler('/practice/9999', context)},
                child: Text('Join Practice 9999')),
          ],
        ),
      ),
    );
  }

  void selectionHandler(String practice, BuildContext context) {
    context.go(practice);
  }
}
