import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swim_timer/pages/practice/practice_cubit/practice_state.dart';

export 'practice_state.dart';

class PracticeCubit extends Cubit<PracticeState> {
  PracticeCubit() : super(const PracticeState());

  void setTab(PracticeTab tab) => emit(PracticeState(tab: tab));
}
