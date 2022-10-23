import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swim_timer/pages/create/create_bloc/create_event.dart';
import 'package:swim_timer/pages/create/create_bloc/create_state.dart';

class CreateBloc extends Bloc<CreateEvent, CreateState> {
  CreateBloc() : super(CreateState(currentStep: CreateStep.name)) {
    on<CreateEvent_SetStep>(_onStepChange);
  }

  _onStepChange(CreateEvent_SetStep event, Emitter<CreateState> emit) {
    emit(state.copyWith(currentStep: event.step));
  }
}
