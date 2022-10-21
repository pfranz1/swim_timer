import 'package:equatable/equatable.dart';
import 'package:practice_repository/practice_repository.dart';
import 'package:entities/entities.dart';

enum StarterStatus { initial, loading, success, failure }

enum SelectedAction { edit, deblock, delete }

class StarterState extends Equatable {
  final List<Swimmer> blockSwimmers;
  final List<List<Swimmer>> blockSwimmersByLane;
  final List<Swimmer> deckSwimmers;
  final List<Swimmer?> recentlyStarted;
  final Swimmer? selectedSwimmer;
  final SelectedAction? selectedAction;
  final StarterStatus status;

  final bool canUndoStart;

  const StarterState({
    this.blockSwimmers = const [],
    this.blockSwimmersByLane = const [],
    this.deckSwimmers = const [],
    this.recentlyStarted = const [],
    this.selectedSwimmer,
    this.selectedAction,
    this.status = StarterStatus.initial,
    this.canUndoStart = false,
  });

  StarterState copyWith({
    List<Swimmer> Function()? blockSwimmers,
    List<List<Swimmer>> Function()? blockSwimmersByLane,
    List<Swimmer> Function()? deckSwimmers,
    List<Swimmer?> Function()? recentlyStarted,
    Swimmer? Function()? selectedSwimmer,
    SelectedAction? Function()? selectedAction,
    StarterStatus Function()? status,
    bool? canUndoStart,
  }) {
    return StarterState(
      blockSwimmers:
          blockSwimmers != null ? blockSwimmers() : this.blockSwimmers,
      blockSwimmersByLane: blockSwimmersByLane != null
          ? blockSwimmersByLane()
          : this.blockSwimmersByLane,
      deckSwimmers: deckSwimmers != null ? deckSwimmers() : this.deckSwimmers,
      selectedSwimmer:
          selectedSwimmer != null ? selectedSwimmer() : this.selectedSwimmer,
      recentlyStarted:
          recentlyStarted != null ? recentlyStarted() : this.recentlyStarted,
      selectedAction:
          selectedAction != null ? selectedAction() : this.selectedAction,
      status: status != null ? status() : this.status,
      canUndoStart: canUndoStart ?? this.canUndoStart,
    );
  }

  StarterState clearAllSelections() {
    return copyWith(selectedAction: () => null, selectedSwimmer: () => null);
  }

  @override
  List<Object?> get props => [
        canUndoStart,
        selectedSwimmer,
        selectedAction,
        status,
        ...blockSwimmers,
        deckSwimmers,
      ];
}
