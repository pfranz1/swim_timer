import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swim_timer/lane/bloc/lane_event.dart';
import 'package:swim_timer/lane/bloc/lane_state.dart';

/// LANE BLOC
class LaneBloc extends Bloc<LaneEvent, LaneState> {
  LaneBloc() : super(const LaneState(<String>[])) {
    on<LaneAdd>(_onAdd);
    on<LaneRemove>(_onRemove);
  }

  void _onAdd(LaneAdd event, Emitter<LaneState> emit) {
    print("On Add Called");
    emit(state.copyWith(swimmers: [...state.swimmers, event.addee]));
  }

  void _onRemove(LaneRemove event, Emitter<LaneState> emit) {
    print("On Remove Called");
    emit(state.copyWith(swimmers: state.swimmers.sublist(1)));
  }
}
