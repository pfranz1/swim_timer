import 'package:equatable/equatable.dart';
import 'package:practice_repository/practice_repository.dart';

abstract class StopperEvent extends Equatable {
  const StopperEvent();

  @override
  List<Object> get props => [];
}

class SubscriptionRequested extends StopperEvent {}

class TapSwimmer extends StopperEvent {
  const TapSwimmer(
      {required this.lane, required this.swimmer, required this.time});

  final int lane;
  final Swimmer swimmer;
  final DateTime time;

  @override
  List<Object> get props => [lane, swimmer];
}

class TapUndo extends StopperEvent {
  final String id;
  final DateTime startTime;
  final int lane;

  const TapUndo(
      {required this.id, required this.startTime, required this.lane});
}

class StaleFinisher extends StopperEvent {
  final String id;
  final int lane;

  const StaleFinisher({required this.id, required this.lane});

  @override
  List<Object> get props => [id, lane];
}
