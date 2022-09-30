//TODO: Make barrel file

import 'package:equatable/equatable.dart';
import 'package:practice_repository/practice_repository.dart';
import 'package:swim_timer/pages/practice/starter/starter_bloc/starter_bloc.dart';

abstract class StarterBlocEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SubscriptionRequested extends StarterBlocEvent {
  SubscriptionRequested();
}

class TapAway extends StarterBlocEvent {}

class TapSwimmer extends StarterBlocEvent {
  TapSwimmer(this.swimmer, this.isOnBlock);

  final Swimmer? swimmer;
  final bool isOnBlock;

  @override
  List<Object> get props => [swimmer?.id ?? "null", isOnBlock];
}

class TapLane extends StarterBlocEvent {
  TapLane(this.lane, this.swimmer);

  final int lane;
  final Swimmer? swimmer;

  @override
  List<Object> get props => [lane, swimmer ?? ""];
}

class TapStart extends StarterBlocEvent {
  final DateTime start;

  TapStart(this.start);

  @override
  List<Object> get props => [start];
}

class TapUndo extends StarterBlocEvent {}

class StaleUndo extends StarterBlocEvent {}

class TapAction extends StarterBlocEvent {
  final SelectedAction action;

  TapAction({required this.action});

  @override
  List<Object> get props => [action];
}

class TapAdd extends StarterBlocEvent {}
