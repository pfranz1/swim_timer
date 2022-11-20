import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:practice_api/practice_api.dart';
import 'package:entities/entities.dart';

enum OverviewStatus { inital, loading, succsess, failure }

class OverviewState extends Equatable {
  final List<FinisherEntry>? entries;
  final OverviewStatus status;

  // Because I only have 4 bools Im not going to bother with bigger
  // solution for more filters, this could be refactored to be better

  final bool showFree;
  final bool showBack;
  final bool showBreast;
  final bool showFly;

  const OverviewState({
    this.entries,
    this.status = OverviewStatus.inital,
    this.showFree = true,
    this.showBack = true,
    this.showBreast = true,
    this.showFly = true,
  });

  OverviewState copyWith({
    List<FinisherEntry> Function()? entries,
    OverviewStatus? status,
    bool? showFree,
    bool? showBack,
    bool? showBreast,
    bool? showFly,
  }) {
    return OverviewState(
      entries: entries != null ? entries() : this.entries,
      status: status ?? this.status,
      showFree: showFree ?? this.showFree,
      showBack: showBack ?? this.showBack,
      showBreast: showBreast ?? this.showBreast,
      showFly: showFly ?? this.showFly,
    );
  }

  OverviewState oneSelected({required Stroke stroke}) {
    return copyWith(
      showFree: Stroke.FREE_STYLE == stroke,
      showBack: Stroke.BACK_STROKE == stroke,
      showBreast: Stroke.BREAST_STROKE == stroke,
      showFly: Stroke.BUTTERFLY == stroke,
    );
  }

  @override
  List<Object> get props =>
      [status, ...?entries, showFree, showBack, showBreast, showFly];
}
