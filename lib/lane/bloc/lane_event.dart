import 'package:equatable/equatable.dart';

/// LANE EVENT
abstract class LaneEvent extends Equatable {
  const LaneEvent();

  @override
  List<Object> get props => [];
}

class LaneAdd extends LaneEvent {
  final String addee;

  const LaneAdd(this.addee);

  @override
  List<Object> get props => [addee];
}

class LaneRemove extends LaneEvent {
  final String removee;

  const LaneRemove(this.removee);

  @override
  List<Object> get props => [removee];
}
