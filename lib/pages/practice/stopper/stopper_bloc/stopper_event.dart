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
