import 'package:equatable/equatable.dart';
import 'package:practice_repository/practice_repository.dart';

enum StarterStatus { inital, loading, succsess, failure }

enum SelectedAction { edit, deblock, delete }

class StarterState extends Equatable {
  final List<Swimmer> blockSwimmers;
  final List<Swimmer> deckSwimmers;
  final List<Swimmer?> recentlyStarted;
  final Swimmer? selectedSwimmer;
  final SelectedAction? selectedAction;
  final int? selectedLane;
  final StarterStatus status;

  final bool canUndoStart;

  const StarterState({
    this.blockSwimmers = const [],
    this.deckSwimmers = const [],
    this.recentlyStarted = const [],
    this.selectedSwimmer,
    this.selectedAction,
    this.selectedLane,
    this.status = StarterStatus.inital,
    this.canUndoStart = false,
  });

  StarterState copyWith({
    List<Swimmer> Function()? blockSwimmers,
    List<Swimmer> Function()? deckSwimmers,
    List<Swimmer?> Function()? recentlyStarted,
    Swimmer? Function()? selectedSwimmer,
    SelectedAction? Function()? selectedAction,
    int? Function()? selectedLane,
    StarterStatus Function()? status,
    bool? canUndoStart,
  }) {
    return StarterState(
      blockSwimmers:
          blockSwimmers != null ? blockSwimmers() : this.blockSwimmers,
      deckSwimmers: deckSwimmers != null ? deckSwimmers() : this.deckSwimmers,
      selectedSwimmer:
          selectedSwimmer != null ? selectedSwimmer() : this.selectedSwimmer,
      recentlyStarted:
          recentlyStarted != null ? recentlyStarted() : this.recentlyStarted,
      selectedAction:
          selectedAction != null ? selectedAction() : this.selectedAction,
      selectedLane: selectedLane != null ? selectedLane() : this.selectedLane,
      status: status != null ? status() : this.status,
      canUndoStart: canUndoStart ?? this.canUndoStart,
    );
  }

  @override
  List<Object?> get props => [
        canUndoStart,
        selectedSwimmer,
        selectedAction,
        selectedLane,
        status,
        ...blockSwimmers,
        deckSwimmers,
      ];
}
