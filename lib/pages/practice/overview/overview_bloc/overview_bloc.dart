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

  List<FinisherEntry> data = [];

  OverviewBloc({required praticeRepository})
      : _practiceRepository = praticeRepository,
        super(const OverviewState()) {
    on<SubscriptionRequested>(_subscriptionRequested);
    on<StrokeFilterSelectedToBeOnly>(_strokeSelectedToBeOnly);
    on<StrokeFilterTapped>(_strokeFilterTapped);
    on<SwimmerSelected>(_onSwimmerSelected);
  }

  bool entryMeetsFilter(FinisherEntry entry) {
    if (state.filterWithId != null) {
      if (entry.id != state.filterWithId) return false;
    }

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
        break;
      case Stroke.BACK_STROKE:
        emit(state.copyWith(showBack: !event.isAdding));
        break;
      case Stroke.BREAST_STROKE:
        emit(state.copyWith(showBreast: !event.isAdding));
        break;
      case Stroke.BUTTERFLY:
        emit(state.copyWith(showFly: !event.isAdding));
        break;
      default:
    }

    emit(state.copyWith(entries: () => data.where(entryMeetsFilter).toList()));
  }

  Future<void> _strokeSelectedToBeOnly(
      StrokeFilterSelectedToBeOnly event, Emitter<OverviewState> emit) async {
    // Change filter of state
    emit(state.oneSelected(stroke: event.stroke));

    // Re-filter data
    emit(state.copyWith(entries: () => data.where(entryMeetsFilter).toList()));
  }

  Future<void> _onSwimmerSelected(
      SwimmerSelected event, Emitter<OverviewState> emit) async {
    emit(state.copyWith(filterWithId: () => event.idOfSwimmer));

    emit(state.copyWith(entries: () => data.where(entryMeetsFilter).toList()));
  }

  Future<void> _subscriptionRequested(
      SubscriptionRequested event, Emitter<OverviewState> emit) async {
    emit(state.copyWith(status: OverviewStatus.loading));

    await emit.forEach<List<FinisherEntry>>(
      _practiceRepository.getEntries(),
      onData: (List<FinisherEntry> data) {
        this.data = data.toList();
        return state.copyWith(
            entries: () => data.where(entryMeetsFilter).toList(),
            status: OverviewStatus.succsess);
      },
      onError: (error, stackTrace) =>
          state.copyWith(status: OverviewStatus.failure),
    );
  }
}
