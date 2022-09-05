import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:practice_api/practice_api.dart';

enum StopperStatus { inital, loading, success, failure }

@immutable
class StopperState extends Equatable {
  final StopperStatus status;
  final List<List<Swimmer>> lanesOfSwimmers;

  //TODO: Would love if the lane of swimmers wansnt growable,
  // Maybe it should be feed the lane number from a bloc above it?

  const StopperState({
    this.status = StopperStatus.inital,
    this.lanesOfSwimmers = const [],
  });

  StopperState copyWith({
    StopperStatus? status,
    List<List<Swimmer>>? lanesOfSwimmers,
  }) {
    return StopperState(
        status: status ?? this.status,
        lanesOfSwimmers: lanesOfSwimmers ?? this.lanesOfSwimmers);
  }

  @override
  List<Object> get props => [status, lanesOfSwimmers];
}
