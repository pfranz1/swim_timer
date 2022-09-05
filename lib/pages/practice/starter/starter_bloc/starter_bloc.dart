import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_api/practice_api.dart';
import 'package:practice_repository/practice_repository.dart';
import 'package:swim_timer/pages/practice/starter/starter_bloc/starter_event.dart';
import 'package:swim_timer/pages/practice/starter/starter_bloc/starter_state.dart';

export 'starter_event.dart';
export 'starter_state.dart';

class StarterBloc extends Bloc<StarterBlocEvent, StarterState> {
  StarterBloc({required PracticeRepository practiceRepository})
      : _practiceRepository = practiceRepository,
        super(const StarterState()) {
    on<SubscriptionRequested>(_onSubscriptionRequested);
    on<TapLane>(_onTapLane);
    on<TapSwimmer>(_onTapSwimmer);
    on<TapEdit>(_onTapEdit);
    on<TapStart>(_onTapStart);
    on<TapReset>(_onTapReset);
    on<TapAdd>(_onTapAdd);
  }

  final PracticeRepository _practiceRepository;

  Future<void> _onSubscriptionRequested(
    SubscriptionRequested request,
    Emitter<StarterState> emit,
  ) async {
    emit(state.copyWith(status: () => StarterStatus.loading));

    await emit.forEach<List<Swimmer>>(
      _practiceRepository.getSwimmers(),
      onData: (swimmers) => state.copyWith(
        // Set status to succsess
        status: () => StarterStatus.succsess,
        // Filter all swimmers to the ones on the block
        blockSwimmers: () => swimmers
            .where((element) =>
                (element.lane != null && element.lane! > 0) &&
                element.startTime == null)
            .toList(),
        // Filter all swimmer to the ones on deck
        deckSwimmers: () => swimmers
            .where((element) => element.lane == 0 || element.lane == null)
            .toList(),
      ),
      onError: (_, __) => state.copyWith(status: () => StarterStatus.failure),
    );
  }

  Future<void> _onTapLane(
    TapLane tapLane,
    Emitter<StarterState> emit,
  ) async {
    if (state.selectedSwimmer != null) {
      if (tapLane.swimmer != null) {
        // Attempting to move swimmer into lane that is occupied

        // Move blocking swimmer
        await _practiceRepository.setLane(tapLane.swimmer!.id, 0);

        // Set selected swimmer
        await _practiceRepository.trySetLane(
            state.selectedSwimmer!.id, tapLane.lane);

        // Clear selected swimmer
        return emit(state.copyWith(selectedSwimmer: () => null));
      } else {
        // Moving swimmer into unocupied lane
        await _practiceRepository.trySetLane(
            state.selectedSwimmer!.id, tapLane.lane);
        // Clear selected swimmer
        return emit(state.copyWith(selectedSwimmer: () => null));
      }
    }
  }

  Future<void> _onTapSwimmer(
    TapSwimmer tapSwimmer,
    Emitter<StarterState> emit,
  ) async {
    // If the user taps aways
    if (tapSwimmer.swimmer == null) {
      emit(state.copyWith(selectedSwimmer: () => null));
      return;
    }

    if (state.selectedAction == null) {
      emit(state.copyWith(selectedSwimmer: () => tapSwimmer.swimmer));
    } else {
      switch (state.selectedAction) {
        case "edit":
          print("EDIT SWIMMER: ${tapSwimmer.swimmer}");
          emit(state.copyWith(selectedAction: () => null));
          break;
        default:
          break;
      }
    }
  }

  Future<void> _onTapEdit(
    TapEdit tapEdit,
    Emitter<StarterState> emit,
  ) async {
    emit(state.copyWith(selectedAction: () => "edit"));
  }

  Future<void> _onTapStart(
    TapStart tapStart,
    Emitter<StarterState> emit,
  ) async {
    for (Swimmer blockSwimmer in state.blockSwimmers) {
      await _practiceRepository.setStartTime(blockSwimmer.id, tapStart.start);
    }
  }

  // TODO: Decide how reset feature should work - server side or client side?
  Future<void> _onTapReset(
    TapReset tapReset,
    Emitter<StarterState> emit,
  ) async {}

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
