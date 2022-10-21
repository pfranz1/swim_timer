import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:organization_api/organization_api.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';

// TODO: Remove this an use one from packages
class PracticeDM {
  final String name;
  final String id;
  final int numSwimmers;
  final DateTime createdOn;

  PracticeDM(
      {required this.name,
      required this.id,
      required this.numSwimmers,
      required this.createdOn});
}

class PracticeTile extends StatelessWidget {
  PracticeTile({super.key, required this.practice});

  final PracticeDM practice;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.go('/practice/${practice.id}');
      },
      borderRadius: BorderRadius.all(Radius.circular(20)),
      child: Container(
        constraints: BoxConstraints(minHeight: 75),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            border: Border.all(
                color: Theme.of(context).colorScheme.primary, width: 2.0)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            children: [
              Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        practice.name,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        DateFormat.MMMEd().format(practice.createdOn),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  )),
              Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Icon(Icons.pool_outlined),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        practice.numSwimmers.toString(),
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
