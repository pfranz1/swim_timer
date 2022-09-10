import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'package:practice_repository/practice_repository.dart';
import 'package:swim_timer/pages/practice/overview/overview_bloc/overview_event.dart';
import 'package:swim_timer/pages/practice/overview/overview_bloc/overview_state.dart';

export 'overview_state.dart';
export 'overview_event.dart';

class OverviewBloc extends Bloc<OverviewEvent, OverviewState> {
  final PracticeRepository _practiceRepository;

  OverviewBloc({required praticeRepository})
      : _practiceRepository = praticeRepository,
        super(const OverviewState()) {
    on<SubscriptionRequested>(_subscriptionRequested);
  }

  Future<void> _subscriptionRequested(
      SubscriptionRequested event, Emitter<OverviewState> emit) async {
    emit(state.copyWith(status: OverviewStatus.loading));

    await emit.forEach<List<FinisherEntry>>(
      _practiceRepository.getEntries(),
      onData: (List<FinisherEntry> data) =>
          state.copyWith(entries: () => data, status: OverviewStatus.succsess),
      onError: (error, stackTrace) =>
          state.copyWith(status: OverviewStatus.failure),
    );
  }
}
