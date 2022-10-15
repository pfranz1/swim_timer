import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_api/practice_api.dart';
import 'package:practice_api/src/stroke.dart';
import 'package:practice_repository/practice_repository.dart';
import 'package:swim_timer/pages/practice/starter/starter_bloc/starter_event.dart';
import 'package:swim_timer/pages/practice/starter/starter_bloc/starter_state.dart';

export 'starter_event.dart';
export 'starter_state.dart';

class StarterBloc extends Bloc<StarterBlocEvent, StarterState> {
  StarterBloc({
    required PracticeRepository practiceRepository,
    required void Function(Swimmer editSwimmer) editNavigationCallBack,
  })  : _practiceRepository = practiceRepository,
        _editNavigationCallBack = editNavigationCallBack,
        super(const StarterState()) {
    on<SubscriptionRequested>(_onSubscriptionRequested);
    on<TapLane>(_onTapLane);
    on<TapSwimmer>(_onTapSwimmer);
    on<TapStart>(_onTapStart);
    on<TapUndo>(_onTapUndo);
    on<TapAdd>(_onTapAdd);
    on<StaleUndo>(_onStaleUndo);
    on<TapAction>(_onTapAction);
    on<TapAway>(_onTapAway);
  }

  final PracticeRepository _practiceRepository;

  final void Function(Swimmer editSwimmer) _editNavigationCallBack;

  static const Duration undoFadeDuration = Duration(seconds: 5);

  Future<void> _onSubscriptionRequested(
    SubscriptionRequested request,
    Emitter<StarterState> emit,
  ) async {
    emit(state.copyWith(status: () => StarterStatus.loading));

    await emit.forEach<StarterData>(
      _practiceRepository.getStarterData(),
      onData: (data) => state.copyWith(
        // Set status to success
        status: () => StarterStatus.success,
        blockSwimmers: () => data.blockSwimmers,
        deckSwimmers: () => data.deckSwimmers,
        blockSwimmersByLane: () => data.blockSwimmersByLane,
      ),
      onError: (_, __) => state.copyWith(status: () => StarterStatus.failure),
    );
  }

  Future<void> _onTapAway(TapAway tapAway, Emitter<StarterState> emit) async {
    emit(state.clearAllSelections());
  }

  Future<void> _onTapLane(
    TapLane tapLane,
    Emitter<StarterState> emit,
  ) async {
    // Handle a lane being taped when an action is active
    if (state.selectedAction != null) {
      // If the lane has a swimmer in it
      if (tapLane.swimmer != null) {
        // Apply action to swimmer
        _handleAction(state.selectedAction, tapLane.swimmer!);
      }
      emit(state.clearAllSelections());
    }

    // If a swimmer has been selected and not taping lane of that selected swimmer
    if (state.selectedSwimmer != null) {
      // If the lane being tapped on has a swimmer in it
      if (tapLane.swimmer != null) {
        // If the lane is occupied by another swimmer (different for currentlySelected)
        if (tapLane.swimmer!.id != state.selectedSwimmer!.id) {
          // Attempting to move swimmer into lane that is occupied

          // // Move blocking swimmer to location of selected (Default to 0 in no lane specified)
          // await _practiceRepository.setLane(
          //     tapLane.swimmer!.id, state.selectedSwimmer?.lane ?? 0);

          // // Set selected swimmer
          // await _practiceRepository.trySetLane(
          //     state.selectedSwimmer!.id, tapLane.lane);
          await _practiceRepository.swapLanes(
            firstId: tapLane.swimmer!.id,
            firstLane: tapLane.lane,
            secondId: state.selectedSwimmer!.id,
            secondLane: state.selectedSwimmer?.lane ?? 0,
          );

          // Clear selections
          return emit(state.clearAllSelections());
        }
        // Else we are tapping on the lane of the selected swimmer
        else {
          // Im interpreting a re-tap as a person wanting to clear their selection
          emit(state.copyWith(
            selectedSwimmer: () => null,
          ));
        }
      } else {
        // Moving swimmer into unocupied lane
        await _practiceRepository.trySetLane(
            state.selectedSwimmer!.id, tapLane.lane);
        // Clear selected swimmer
        return emit(state.copyWith(selectedSwimmer: () => null));
      }
    } else {
      emit(state.copyWith(
        selectedSwimmer: () => tapLane.swimmer,
      ));
    }
  }

  /// Called when someone taps on a swimmer thats on the deck
  Future<void> _onTapSwimmer(
    TapSwimmer tapSwimmer,
    Emitter<StarterState> emit,
  ) async {
    // If there is action selected to resolve
    if (state.selectedAction != null && tapSwimmer.swimmer != null) {
      // Resolve action on tapped on swimmer
      _handleAction(state.selectedAction, tapSwimmer.swimmer!);

      // Clear selected action
      emit(state.copyWith(
        selectedAction: () => null,
      ));
    } else {
      emit(state.copyWith(selectedSwimmer: () => tapSwimmer.swimmer));
    }
  }

  /// Called when an action button is tapped
  Future<void> _onTapAction(
    TapAction tapAction,
    Emitter<StarterState> emit,
  ) async {
    // If a swimmer is already selected
    if (state.selectedSwimmer != null) {
      // Handle the action on the swimmer
      _handleAction(
        tapAction.action,
        state.selectedSwimmer!,
      );
      // Clear the selection of swimmer and emit
      emit(state.copyWith(
        selectedSwimmer: () => null,
      ));
    }
    // If no swimmer is selected
    else {
      // Set the selectedAction to the action just selected
      emit(state.copyWith(selectedAction: () => tapAction.action));
    }
  }

  Future<void> _handleAction(SelectedAction? action, Swimmer swimmer) async {
    switch (action) {
      case SelectedAction.edit:
        _handleEdit(swimmer);
        break;
      case SelectedAction.delete:
        _handleDelete(swimmer.id);
        break;
      case SelectedAction.deblock:
        _handleDeblock(swimmer.id);
        break;
      case null:
        break;
    }
  }

  Future<void> _handleEdit(Swimmer swimmer) async {
    print("EDIT SWIMMER: $swimmer.id");
    // The UI element (the button clicked on), is responsible for changing navigation
    emit(state.clearAllSelections());
    _editNavigationCallBack(swimmer);
  }

  Future<void> _handleDeblock(String id) async {
    print("DEBLOCK SWIMMER : $id");
    await _practiceRepository.setLane(id, 0);
    emit(state.clearAllSelections());
  }

  Future<void> _handleDelete(String id) async {
    print("DELETE SWIMMER : $id");
    await _practiceRepository.removeSwimmer(id);
    emit(state.clearAllSelections());
  }

  Future<void> _onTapStart(
    TapStart tapStart,
    Emitter<StarterState> emit,
  ) async {
    List<Swimmer?> newlyStarted = [];
    bool startedAtLeastOne = false;
    for (Swimmer blockSwimmer in state.blockSwimmers) {
      await _practiceRepository
          .tryStartSwimmer(blockSwimmer.id, tapStart.start)
          .then((value) {
        startedAtLeastOne = startedAtLeastOne || value;
        if (value == true) {
          newlyStarted.add(blockSwimmer);
        } else {
          newlyStarted.add(null);
        }
      });
    }

    // Chaining calls here to be super swag
    emit(state.clearAllSelections().copyWith(
        recentlyStarted: () => newlyStarted, canUndoStart: startedAtLeastOne));

    Future.delayed(undoFadeDuration).then((value) {
      // Try-On to handle error when this is triggered but the bloc is dead
      try {
        add(StaleUndo());
      } on StateError {
        print(
            'NON ISSUE - State Error Occured - Probably a transition to diffrent route');
      }
    });
  }

  // TODO: Decide how reset feature should work - server side or client side?
  Future<void> _onTapUndo(
    TapUndo tapUndo,
    Emitter<StarterState> emit,
  ) async {
    emit(state.copyWith(canUndoStart: false));

    for (Swimmer? swimmerToUndo in state.recentlyStarted) {
      if (swimmerToUndo != null) {
        await _practiceRepository.undoStart(
            swimmerToUndo.id, swimmerToUndo.endTime);
      }
    }
  }

  Future<void> _onStaleUndo(
      StaleUndo staleUndo, Emitter<StarterState> emit) async {
    emit(state.copyWith(canUndoStart: false));
  }

  Future<void> _onTapAdd(
    TapAdd tapAdd,
    Emitter<StarterState> emit,
  ) async {
    // TOOD: Add way to add swimmer with a form
    final newSwimmer = _makeRandomSwimmer();

    await _practiceRepository.addSwimmer(newSwimmer);
  }

  Swimmer _makeRandomSwimmer() {
    List<Stroke> strokes = [
      Stroke.FREE_STYLE,
      Stroke.BACK_STROKE,
      Stroke.BREAST_STROKE,
      Stroke.BUTTERFLY
    ];
    List<String> names = [
      "Kyla",
      "Peter",
      "Henry",
      "Catherine",
      "Bruce",
      "Aaron",
      "Mario",
      "Donkey Kong",
      "Link",
      "Yoshi",
      "Kirby",
      "Fox",
      "Pikachu",
      "Luigi",
      "Ness",
      "Captain Falcon",
      "Jiggly Puff",
      "Peach",
      "Daisy",
      "Bowser",
      "Marth",
      "Gandolf",
      "Pit",
      "King K. Rool"
    ];
    return Swimmer(
        name: names[Random().nextInt(names.length)],
        lane: 0,
        stroke: strokes[Random().nextInt(4)]);
  }
}
