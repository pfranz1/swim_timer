import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_repository/practice_repository.dart';
import 'package:swim_timer/pages/practice/overview/overview_bloc/overview_bloc.dart';
import 'package:entities/entities.dart';

class StrokeFilterBar extends StatelessWidget {
  const StrokeFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OverviewBloc, OverviewState>(builder: (context, state) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StrokeButton(
            isActive: state.showFree,
            stroke: Stroke.FREE_STYLE,
          ),
          StrokeButton(
            isActive: state.showBack,
            stroke: Stroke.BACK_STROKE,
          ),
          StrokeButton(
            isActive: state.showBreast,
            stroke: Stroke.BREAST_STROKE,
          ),
          StrokeButton(
            isActive: state.showFly,
            stroke: Stroke.BUTTERFLY,
          ),
        ],
      );
    });
  }
}

class StrokeButton extends StatelessWidget {
  StrokeButton({
    Key? key,
    required this.stroke,
    required this.isActive,
  }) : super(key: key) {
    switch (stroke) {
      case Stroke.FREE_STYLE:
        color = Colors.green;
        text = "FR";
        break;
      case Stroke.BACK_STROKE:
        color = Colors.red;
        text = "BA";
        break;
      case Stroke.BREAST_STROKE:
        color = Colors.orange;
        text = "BR";
        break;
      case Stroke.BUTTERFLY:
        color = Colors.lightBlue;
        text = "FL";
        break;
      default:
    }
  }

  final Stroke stroke;
  final bool isActive;
  late final Color color;
  late final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => context
          .read<OverviewBloc>()
          .add(StrokeFilterTapped(stroke: stroke, isAdding: isActive)),
      child: Text(text),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
            isActive ? color : color.withOpacity(0.32)),
        shape: MaterialStateProperty.all(CircleBorder()),
        padding: MaterialStateProperty.all(EdgeInsets.all(20)),
      ),
    );
  }
}
