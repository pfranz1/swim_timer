import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:practice_api/practice_api.dart';

enum StopperStatus { inital, loading, success, failure }

@immutable
class StopperState extends Equatable {
  final StopperStatus status;
  final List<List<Swimmer>> lanesOfSwimmers;
  final List<Swimmer?> latestFinishers;

  const StopperState({
    this.status = StopperStatus.inital,
    this.lanesOfSwimmers = const [],
    this.latestFinishers = const [],
  });

  StopperState registerFinisher(
      {required Swimmer finisher, required int finisherLane}) {
    final newFinishers = this.latestFinishers;

    // newFinishers.replaceRange(finisherLane, finisherLane, [finisher]);
    newFinishers.removeAt(finisherLane);
    newFinishers.insert(finisherLane, finisher);

    return copyWith(latestFinishers: newFinishers);
  }

  StopperState copyWith({
    StopperStatus? status,
    List<List<Swimmer>>? lanesOfSwimmers,
    List<Swimmer?>? latestFinishers,
  }) {
    return StopperState(
      status: status ?? this.status,
      lanesOfSwimmers: lanesOfSwimmers ?? this.lanesOfSwimmers,
      latestFinishers: latestFinishers ?? this.latestFinishers,
    );
  }

  @override
  List<Object> get props => [status, lanesOfSwimmers, latestFinishers];
}
