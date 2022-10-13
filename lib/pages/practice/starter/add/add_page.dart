import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:practice_api/practice_api.dart';
import 'package:swim_timer/main.dart';
import 'package:go_router/go_router.dart';

class AddSwimmerPage extends StatelessWidget {
  const AddSwimmerPage({super.key, required this.backLocation});

  final String backLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add"),
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
      body: Column(
        children: [
          // Top of screen
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 0.0,
                  left: 16.0,
                  right: 16.0,
                  top: 16.0,
                ),
                // Blue container
                child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    // Column with elements user can touch
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 0.0,
                            left: 48.0,
                            right: 48.0,
                            top: 48.0,
                          ),
                          child: TextFormField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                filled: true,
                                hintStyle: TextStyle(color: Colors.grey[800]),
                                hintText: "Swimmer name",
                                fillColor: Colors.white),
                          ),
                        ),
                        // Stroke buttons
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      StrokeTile(
                                          stroke: Stroke.FREE_STYLE,
                                          isActive: false),
                                      StrokeTile(
                                          stroke: Stroke.BACK_STROKE,
                                          isActive: false),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      StrokeTile(
                                          stroke: Stroke.BREAST_STROKE,
                                          isActive: false),
                                      StrokeTile(
                                          stroke: Stroke.BUTTERFLY,
                                          isActive: false),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    )),
              ),
            ),
          ),
          // Lower bottom bit
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: FloatingActionButton(
                    child: Icon(Icons.check),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Row(
                        children: [Text('Added Swimmer')],
                        mainAxisAlignment: MainAxisAlignment.center,
                      )));
                    }),
              )
            ],
          )
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.check),
      //   onPressed: () async {
      //     await Future.delayed(Duration(microseconds: 500));
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //     content: Row(
      //   children: [Text('Added Swimmer')],
      //   mainAxisAlignment: MainAxisAlignment.center,
      // )));
      //     // context.go(backLocation);
      //   },
      // ),
    );
  }
}

class StrokeTile extends StatelessWidget {
  StrokeTile({super.key, required this.stroke, required this.isActive}) {
    switch (stroke) {
      case Stroke.FREE_STYLE:
        color = Colors.green;
        strokeName = 'Free';
        break;
      case Stroke.BACK_STROKE:
        color = Colors.red;
        strokeName = 'Back';
        break;
      case Stroke.BREAST_STROKE:
        color = Colors.orange;
        strokeName = 'Breast';
        break;
      case Stroke.BUTTERFLY:
        color = Colors.lightBlue;
        strokeName = 'Fly';
        break;
      default:
    }
  }

  final Stroke stroke;
  final bool isActive;

  late final Color color;
  late final String strokeName;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox.square(
              // constraints: BoxConstraints(
              //   maxWidth: 350,
              //   maxHeight: 350,
              //   minHeight: 150,
              //   minWidth: 150,
              // ),
              dimension: min(
                  max(min(constraints.maxWidth, constraints.maxHeight) / 2, 50),
                  150),
              child: DecoratedBox(
                decoration: BoxDecoration(
                    color: color,
                    border: Border.all(color: Colors.white, width: 3.0),
                    borderRadius: BorderRadius.all(Radius.circular(6.0))),
                child: null,
              )),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text(
              strokeName,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  ?.copyWith(color: Colors.white),
              overflow: TextOverflow.fade,
            ),
          ),
        ],
      );
    });
  }
}
