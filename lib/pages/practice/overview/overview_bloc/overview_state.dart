import 'package:equatable/equatable.dart';
import 'package:practice_api/practice_api.dart';

enum OverviewStatus { inital, loading, succsess, failure }

class OverviewState extends Equatable {
  final List<FinisherEntry>? entries;
  final OverviewStatus status;

  const OverviewState({this.entries, this.status = OverviewStatus.inital});

  OverviewState copyWith(
      {List<FinisherEntry> Function()? entries, OverviewStatus? status}) {
    return OverviewState(
        entries: entries != null ? entries() : this.entries,
        status: status ?? this.status);
  }

  @override
  List<Object> get props => [status, ...?entries];
}
