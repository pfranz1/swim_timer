import 'package:equatable/equatable.dart';

enum PracticeTab { starter, stopper, overview }

class PracticeState extends Equatable {
  const PracticeState({
    this.tab = PracticeTab.starter,
  });

  final PracticeTab tab;

  @override
  List<Object> get props => [tab];
}
