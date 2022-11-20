import 'package:flutter/material.dart';
import 'package:entities/entities.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'package:practice_repository/practice_repository.dart';
import 'package:swim_timer/pages/practice/overview/overview_bloc/overview_event.dart';
import 'package:swim_timer/pages/practice/overview/overview_bloc/overview_state.dart';
import 'package:entities/entities.dart';

export 'overview_state.dart';
export 'overview_event.dart';

class OverviewBloc extends Bloc<OverviewEvent, OverviewState> {
  final PracticeRepository _practiceRepository;

  OverviewBloc({required praticeRepository})
      : _practiceRepository = praticeRepository,
        super(const OverviewState()) {
    on<SubscriptionRequested>(_subscriptionRequested);
    on<StrokeFilterSelectedToBeOnly>(_strokeSelectedToBeOnly);
    on<StrokeFilterTapped>(_strokeFilterTapped);
  }

  bool entryMeetsFilter(FinisherEntry entry) {
    switch (entry.stroke) {
      case Stroke.FREE_STYLE:
        return state.showFree;
      case Stroke.BACK_STROKE:
        return state.showBack;
      case Stroke.BREAST_STROKE:
        return state.showBreast;
      case Stroke.BUTTERFLY:
        return state.showFly;
      default:
        return true;
    }
  }

  Future<void> _strokeFilterTapped(
      StrokeFilterTapped event, Emitter<OverviewState> emit) async {
    switch (event.stroke) {
      case Stroke.FREE_STYLE:
        emit(state.copyWith(showFree: !event.isAdding));
        emit(state.copyWith(
            entries: () => state.entries!.where(entryMeetsFilter).toList()));
        break;
      case Stroke.BACK_STROKE:
        emit(state.copyWith(showBack: !event.isAdding));
        emit(state.copyWith(
            entries: () => state.entries!.where(entryMeetsFilter).toList()));
        break;
      case Stroke.BREAST_STROKE:
        emit(state.copyWith(showBreast: !event.isAdding));
        emit(state.copyWith(
            entries: () => state.entries!.where(entryMeetsFilter).toList()));
        break;
      case Stroke.BUTTERFLY:
        emit(state.copyWith(showFly: !event.isAdding));
        break;
      default:
    }

    final updatedEntries = (await _practiceRepository.getEntries().first)
        .where(entryMeetsFilter)
        .toList();
    emit(state.copyWith(
      entries: () => updatedEntries,
    ));
  }

  Future<void> _strokeSelectedToBeOnly(
      StrokeFilterSelectedToBeOnly event, Emitter<OverviewState> emit) async {
    emit(state.oneSelected(stroke: event.stroke));
    emit(state.copyWith(
        entries: () => state.entries!.where(entryMeetsFilter).toList()));

    final updatedEntries = (await _practiceRepository.getEntries().first)
        .where(entryMeetsFilter)
        .toList();
    emit(state.copyWith(
      entries: () => updatedEntries,
    ));
  }

  Future<void> _subscriptionRequested(
      SubscriptionRequested event, Emitter<OverviewState> emit) async {
    emit(state.copyWith(status: OverviewStatus.loading));

    await emit.forEach<List<FinisherEntry>>(
      _practiceRepository.getEntries(),
      onData: (List<FinisherEntry> data) => state.copyWith(
          entries: () => data.where(entryMeetsFilter).toList(),
          status: OverviewStatus.succsess),
      onError: (error, stackTrace) =>
          state.copyWith(status: OverviewStatus.failure),
    );
  }
}
