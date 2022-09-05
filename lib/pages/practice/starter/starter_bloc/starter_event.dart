//TODO: Make barrel file

import 'package:equatable/equatable.dart';
import 'package:practice_repository/practice_repository.dart';

abstract class StarterBlocEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SubscriptionRequested extends StarterBlocEvent {
  SubscriptionRequested();
}

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

class TapEdit extends StarterBlocEvent {}

class TapStart extends StarterBlocEvent {
  final DateTime start;

  TapStart(this.start);

  @override
  List<Object> get props => [start];
}

class TapReset extends StarterBlocEvent {}

class TapAdd extends StarterBlocEvent {}
