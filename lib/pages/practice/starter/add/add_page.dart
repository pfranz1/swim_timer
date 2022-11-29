import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:practice_api/practice_api.dart';
import 'package:entities/entities.dart';
import 'package:practice_repository/practice_repository.dart';
import 'package:swim_timer/custom_colors.dart';
import 'package:swim_timer/main.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:common/common.dart';

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

class _AddSwimmerPageState extends State<AddSwimmerPage> {
  final TextEditingController _nameController = TextEditingController();
  Stroke? selectedStroke;

  static const snackBarDuration = Duration(milliseconds: 1500);

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
      final scaffoldMessenger = ScaffoldMessenger.of(context);

      await context.read<PracticeRepository>().addSwimmer(
          Swimmer(name: _nameController.text, stroke: selectedStroke));

      context.go(widget.backLocation);

      // So the snack bar appears after navigation
      await Future.delayed(Duration(milliseconds: 150));

      scaffoldMessenger.showSnackBar(SnackBar(
        content: Row(
          children: [
            Text(
                'Added ${_nameController.text}, Swimming ${Common.strokeToString[selectedStroke]}')
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
        duration: snackBarDuration,
      ));

      // setState(() {
      //   selectedStroke = null;
      //   _nameController.clear();
      // });

    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Row(
          children: [Text('Please specify name and stroke')],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
        duration: snackBarDuration,
      ));
    }
  }

  void _handleEditTap() async {
    if (selectedStroke != null) {
      //ON check mark tap!!
      await context
          .read<PracticeRepository>()
          .setStroke(widget.editSwimmer!.id, selectedStroke!);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Row(
          children: [
            Text(
                '${widget.editSwimmer!.name} => ${Common.strokeToString[selectedStroke]}')
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
        duration: snackBarDuration,
      ));
      context.go(widget.backLocation);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Row(
          children: [Text('Please specify stroke')],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
        duration: snackBarDuration,
      ));
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
                color: CustomColors.primeColor,
              )),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFE6F3F9),
                  Color(0xFFC6E3EE),
                  Color(0xFFAAF6FF)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
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
                              color: CustomColors.primeColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
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
                                  autofocus: true,
                                  keyboardType: TextInputType.name,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) => _handleAddTap(),
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      filled: true,
                                      hintStyle:
                                          TextStyle(color: Colors.grey[800]),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
          ),
        ));
  }
}

class StrokeTile extends StatelessWidget {
  StrokeTile(
      {super.key,
      required this.stroke,
      required this.isActive,
      required this.onTap}) {
    icon = AssetImage(strokeIconPaths[stroke]!);
    switch (stroke) {
      case Stroke.FREE_STYLE:
        color = Color(0xFF62CA50);
        strokeName = 'Free';
        break;
      case Stroke.BACK_STROKE:
        color = Color(0xFFD42A34);
        strokeName = 'Back';
        break;
      case Stroke.BREAST_STROKE:
        color = Color(0xFFF78C37);
        strokeName = 'Breast';
        break;
      case Stroke.BUTTERFLY:
        color = Color(0xFF0677BA);
        strokeName = 'Fly';
        break;
      default:
    }
  }

  //TODO: Centralize this information (forgive my sins lol)
  final Map<Stroke, String> strokeIconPaths = const {
    Stroke.FREE_STYLE: "assets/images/freestyle_w.png",
    Stroke.BACK_STROKE: "assets/images/backstroke_w.png",
    Stroke.BREAST_STROKE: "assets/images/breaststroke_w.png",
    Stroke.BUTTERFLY: "assets/images/butterfly_w.png",
  };

  final Stroke stroke;
  final bool isActive;

  final Function(Stroke) onTap;

  late final Color color;
  late final String strokeName;
  late final AssetImage icon;

  static const minHeightForUnconstrained = 200;
  static const double padding = 4.0;
  static const double iconSize = 30;
  static const double iconSizeGrow = 20;
  static const double cardSizeGrow = 30;

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVis) {
      return LayoutBuilder(builder: (context, constraints) {
        final double tileMainDimension = min(
            max(min(constraints.maxWidth, constraints.maxHeight) / 2, 50), 150);
        final showCompressedView =
            isKeyboardVis || constraints.maxHeight < minHeightForUnconstrained;
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height: tileMainDimension,
                width:
                    tileMainDimension + (showCompressedView ? cardSizeGrow : 0),
                child: GestureDetector(
                  onTap: () => onTap(stroke),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        color: color,
                        border: Border.all(
                            color: isActive ? Colors.white38 : Colors.white24,
                            width: isActive ? 8.0 : 3.0),
                        borderRadius: BorderRadius.all(Radius.circular(6.0))),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Center(
                        child: SizedBox.square(
                          dimension: iconSize +
                              (showCompressedView ? 0 : iconSizeGrow),
                          child: Image(
                            image: icon,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    ),
                  ),
                )),
            if (showCompressedView == false)
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  strokeName,
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                      color: Colors.white,
                      fontWeight:
                          isActive ? FontWeight.bold : FontWeight.normal),
                  overflow: TextOverflow.fade,
                ),
              ),
          ],
        );
      });
    });
  }
}
