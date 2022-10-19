import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:practice_api/practice_api.dart';
import 'package:practice_repository/practice_repository.dart';
import 'package:swim_timer/main.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AddSwimmerPage extends StatefulWidget {
  AddSwimmerPage({
    super.key,
    required this.backLocation,
    this.editSwimmer,
  });

  final String backLocation;
  final Swimmer? editSwimmer;

  @override
  State<AddSwimmerPage> createState() => _AddSwimmerPageState();
}

// TODO: Do this is a centeralized spot
Map<Stroke, String> strokeToString = {
  Stroke.FREE_STYLE: "Free",
  Stroke.BACK_STROKE: "Back",
  Stroke.BREAST_STROKE: "Breast",
  Stroke.BUTTERFLY: "Fly"
};

class _AddSwimmerPageState extends State<AddSwimmerPage> {
  final TextEditingController _nameController = TextEditingController();
  Stroke? selectedStroke;

  @override
  void initState() {
    final TextEditingController _nameController =
        TextEditingController(text: widget.editSwimmer?.name);
    selectedStroke = widget.editSwimmer?.stroke;
    super.initState();
  }

  void _handleStrokeTap(Stroke stroke) {
    print('Handle $stroke ${_nameController.text}');
    setState(() {
      selectedStroke = stroke;
    });
  }

  void _handleAddTap() async {
    if (_nameController.value.text.isNotEmpty && selectedStroke != null) {
      await context.read<PracticeRepository>().addSwimmer(
          Swimmer(name: _nameController.text, stroke: selectedStroke));

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Row(
        children: [
          Text(
              'Added ${_nameController.text}, Swimming ${strokeToString[selectedStroke]}')
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      )));

      setState(() {
        selectedStroke = null;
        _nameController.clear();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Row(
        children: [Text('Please specify name and stroke')],
        mainAxisAlignment: MainAxisAlignment.center,
      )));
    }
  }

  void _handleEditTap() async {
    if (selectedStroke != null) {
      await context
          .read<PracticeRepository>()
          .setStroke(widget.editSwimmer!.id, selectedStroke!);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Row(
        children: [
          Text(
              '${widget.editSwimmer!.name} => ${strokeToString[selectedStroke]}')
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      )));
      context.go(widget.backLocation);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Row(
        children: [Text('Please specify stroke')],
        mainAxisAlignment: MainAxisAlignment.center,
      )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text((widget.editSwimmer == null) ? "Add" : "Edit"),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              context.go(widget.backLocation);
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
                            // Enabled when adding
                            enabled: widget.editSwimmer == null,
                            controller: _nameController,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                filled: true,
                                hintStyle: TextStyle(color: Colors.grey[800]),
                                hintText: widget.editSwimmer == null
                                    ? "Swimmer name"
                                    : widget.editSwimmer!.name,
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
                                          onTap: _handleStrokeTap,
                                          stroke: Stroke.FREE_STYLE,
                                          isActive: selectedStroke ==
                                              Stroke.FREE_STYLE),
                                      StrokeTile(
                                          onTap: _handleStrokeTap,
                                          stroke: Stroke.BACK_STROKE,
                                          isActive: selectedStroke ==
                                              Stroke.BACK_STROKE),
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
                                          onTap: _handleStrokeTap,
                                          stroke: Stroke.BREAST_STROKE,
                                          isActive: selectedStroke ==
                                              Stroke.BREAST_STROKE),
                                      StrokeTile(
                                          onTap: _handleStrokeTap,
                                          stroke: Stroke.BUTTERFLY,
                                          isActive: selectedStroke ==
                                              Stroke.BUTTERFLY),
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
                // Check to add swimmer button
                child: FloatingActionButton(
                    child: Icon(Icons.check),
                    onPressed: (widget.editSwimmer == null)
                        ? _handleAddTap
                        : _handleEditTap),
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
  StrokeTile(
      {super.key,
      required this.stroke,
      required this.isActive,
      required this.onTap}) {
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

  final Function(Stroke) onTap;

  late final Color color;
  late final String strokeName;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox.square(
              dimension: min(
                  max(min(constraints.maxWidth, constraints.maxHeight) / 2, 50),
                  150),
              child: GestureDetector(
                onTap: () => onTap(stroke),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      color: color,
                      border: Border.all(
                          color: isActive ? Colors.white38 : Colors.white24,
                          width: isActive ? 8.0 : 3.0),
                      borderRadius: BorderRadius.all(Radius.circular(6.0))),
                  child: null,
                ),
              )),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text(
              strokeName,
              style: Theme.of(context).textTheme.headline6?.copyWith(
                  color: Colors.white,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal),
              overflow: TextOverflow.fade,
            ),
          ),
        ],
      );
    });
  }
}
