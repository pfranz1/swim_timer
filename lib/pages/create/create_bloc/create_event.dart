import 'package:equatable/equatable.dart';
import 'package:swim_timer/pages/create/create_bloc/create_state.dart';

class CreateEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateEvent_SetStep extends CreateEvent {
  CreateStep step;

  CreateEvent_SetStep({required this.step});

  @override
  List<Object?> get props => [step];
}

class CreateEvent_SetName extends CreateEvent {
  String? name;

  CreateEvent_SetName({this.name});

  @override
  List<Object?> get props => [name];
}
