import 'package:equatable/equatable.dart';
import 'package:practice_repository/practice_repository.dart';

enum StarterStatus { inital, loading, succsess, failure }

class StarterState extends Equatable {
  final List<Swimmer> blockSwimmers;
  final List<Swimmer> deckSwimmers;
  final Swimmer? selectedSwimmer;
  final String? selectedAction;
  final int? selectedLane;
  final StarterStatus status;

  const StarterState({
    this.blockSwimmers = const [],
    this.deckSwimmers = const [],
    this.selectedSwimmer,
    this.selectedAction,
    this.selectedLane,
    this.status = StarterStatus.inital,
  });

  StarterState copyWith({
    List<Swimmer> Function()? blockSwimmers,
    List<Swimmer> Function()? deckSwimmers,
    Swimmer? Function()? selectedSwimmer,
    String? Function()? selectedAction,
    int? Function()? selectedLane,
    StarterStatus Function()? status,
  }) {
    return StarterState(
      blockSwimmers:
          blockSwimmers != null ? blockSwimmers() : this.blockSwimmers,
      deckSwimmers: deckSwimmers != null ? deckSwimmers() : this.deckSwimmers,
      selectedSwimmer:
          selectedSwimmer != null ? selectedSwimmer() : this.selectedSwimmer,
      selectedAction:
          selectedAction != null ? selectedAction() : this.selectedAction,
      selectedLane: selectedLane != null ? selectedLane() : this.selectedLane,
      status: status != null ? status() : this.status,
    );
  }

  @override
  List<Object?> get props => [
        selectedSwimmer,
        selectedAction,
        selectedLane,
        status,
        blockSwimmers,
        deckSwimmers,
      ];
}
