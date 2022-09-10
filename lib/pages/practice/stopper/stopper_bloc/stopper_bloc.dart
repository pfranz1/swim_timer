import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_repository/practice_repository.dart';
import 'package:swim_timer/pages/practice/stopper/stopper_bloc/stopper_event.dart';
import 'package:swim_timer/pages/practice/stopper/stopper_bloc/stopper_state.dart';

export 'stopper_event.dart';
export 'stopper_state.dart';

class StopperBloc extends Bloc<StopperEvent, StopperState> {
  final PracticeRepository _practiceRepository;

  static const Duration _undoStayingTime = Duration(seconds: 5);

  StopperBloc({
    required PracticeRepository practiceRepository,
  })  : _practiceRepository = practiceRepository,
        super(const StopperState(
            status: StopperStatus.inital, lanesOfSwimmers: [])) {
    on<SubscriptionRequested>(_onSubscriptionRequested);
    on<TapSwimmer>(_onTapSwimmer);
    on<TapUndo>(_onTapUndo);
    on<StaleFinisher>(_onStaleFinisher);
  }

  Future<void> _onSubscriptionRequested(
    SubscriptionRequested event,
    Emitter<StopperState> emit,
  ) async {
    emit(state.copyWith(
        status: StopperStatus.loading,
        latestFinishers: [for (var x = 0; x <= 6; x++) null]));

    await emit.forEach(_practiceRepository.getPoolSwimmerByLane(),
        onData: ((List<List<Swimmer>> data) => state.copyWith(
            status: StopperStatus.success, lanesOfSwimmers: data)),
        onError: (_, __) => state.copyWith(status: StopperStatus.failure));
  }

  Future<void> _onTapSwimmer(
    TapSwimmer event,
    Emitter<StopperState> emit,
  ) async {
    await _practiceRepository
        .tryEndSwimmer(event.swimmer.id, event.time)
        .then((value) {
      if (value == true) {
        emit(state.registerFinisher(
            finisher: event.swimmer, finisherLane: event.lane));

        Future.delayed(_undoStayingTime).then((_) =>
            {add(StaleFinisher(id: event.swimmer.id, lane: event.lane))});
      }
    });
  }

  Future<void> _onTapUndo(TapUndo undo, Emitter<StopperState> emitter) async {
    await _practiceRepository
        .resetSwimmer(undo.id, undo.startTime, undo.lane)
        .then((value) => emit(state.removeFinisher(undo.lane)));
  }

  Future<void> _onStaleFinisher(
      StaleFinisher event, Emitter<StopperState> emit) async {
    if (state.latestFinishers[event.lane]?.id != null &&
        state.latestFinishers[event.lane]!.id == event.id) {
      final newFinishers = state.latestFinishers;
      newFinishers[event.lane] = null;
      emit(
        state.copyWith(
            latestFinishers: newFinishers,
            staleCount: state.staleCount + 1 % 100),
      );
    }
  }
}
