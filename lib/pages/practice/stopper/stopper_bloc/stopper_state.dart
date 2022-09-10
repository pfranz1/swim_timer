import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:practice_api/practice_api.dart';
import 'package:swim_timer/pages/practice/stopper/stopper_bloc/stopper_bloc.dart';

enum StopperStatus { inital, loading, success, failure }

@immutable
class StopperState extends Equatable {
  final StopperStatus status;
  final List<List<Swimmer>> lanesOfSwimmers;
  final List<Swimmer?> latestFinishers;

  // Struggled to get the bloc rebuilding after the bloc changed the latest finishers
  // It seems like equatable doesnt dig too deep into the values of the list when nullifiable
  // SO -  I need something to change when I change the latestFinishers so a rebuild happens
  // Hence staleCount

  /// Variable to make state diffrent in way equatable can understand when you
  /// set latest swimmer to null in latestSwimmer to mark that person as being
  /// done for a while and not undo-able
  final int staleCount;

  const StopperState({
    this.status = StopperStatus.inital,
    this.lanesOfSwimmers = const [],
    this.latestFinishers = const [],
    this.staleCount = 0,
  });

  StopperState registerFinisher(
      {required Swimmer finisher, required int finisherLane}) {
    final newFinishers = this.latestFinishers;

    // newFinishers.replaceRange(finisherLane, finisherLane, [finisher]);
    newFinishers.removeAt(finisherLane);
    newFinishers.insert(finisherLane, finisher);

    return copyWith(latestFinishers: newFinishers);
  }

  StopperState removeFinisher(int lane) {
    final newFinishers = this.latestFinishers;

    // newFinishers.replaceRange(finisherLane, finisherLane, [finisher]);
    newFinishers[lane] = null;

    return copyWith(latestFinishers: newFinishers);
  }

  StopperState copyWith({
    StopperStatus? status,
    List<List<Swimmer>>? lanesOfSwimmers,
    List<Swimmer?>? latestFinishers,
    int? staleCount,
  }) {
    return StopperState(
      status: status ?? this.status,
      lanesOfSwimmers: lanesOfSwimmers ?? this.lanesOfSwimmers,
      latestFinishers: latestFinishers ?? this.latestFinishers,
      staleCount: staleCount ?? this.staleCount,
    );
  }

  @override
  List<Object> get props => [
        status,
        lanesOfSwimmers,
        latestFinishers,
        staleCount,
        // ...[for (final finisher in latestFinishers) finisher ?? "NULL"]
      ];
}
