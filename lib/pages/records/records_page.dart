import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:go_router/go_router.dart';

class RecordsPage extends StatelessWidget {
  const RecordsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Records"),
        leading: IconButton(
            onPressed: () => {context.go('/')}, icon: Icon(Icons.chevron_left)),
        centerTitle: true,
      ),
      body: Center(child: Text('See records here one day')),
    );
  }
}
