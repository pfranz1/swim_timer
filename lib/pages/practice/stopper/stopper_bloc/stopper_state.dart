import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:practice_api/practice_api.dart';

enum StopperStatus { inital, loading, success, failure }

@immutable
class StopperState extends Equatable {
  final StopperStatus status;
  final List<List<Swimmer>> lanesOfSwimmers;
  final List<Swimmer?> latestFinishers;

  //TODO: Would love if the lane of swimmers wansnt growable,
  // Maybe it should be feed the lane number from a bloc above it?

  const StopperState({
    this.status = StopperStatus.inital,
    this.lanesOfSwimmers = const [],
    this.latestFinishers = const [],
  });

  StopperState copyWith({
    StopperStatus? status,
    List<List<Swimmer>>? lanesOfSwimmers,
    Swimmer? finisher,
    int? finisherLane,
  }) {
    //These should always be done at the same time
    if (finisher != null && finisherLane != null) {
      // DO something to have an undo
    }

    return StopperState(
      status: status ?? this.status,
      lanesOfSwimmers: lanesOfSwimmers ?? this.lanesOfSwimmers,
      latestFinishers: latestFinishers,
    );
  }

  @override
  List<Object> get props => [status, lanesOfSwimmers];
}
