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

  final Swimmer swimmer;
  final bool isOnBlock;

  @override
  List<Object> get props => [swimmer.id, isOnBlock];
}

class TapLane extends StarterBlocEvent {
  TapLane(this.lane);

  final int lane;

  @override
  List<Object> get props => [lane];
}

class TapAction extends StarterBlocEvent {
  TapAction(this.action);

  final String action;

  @override
  List<Object> get props => [action];
}
