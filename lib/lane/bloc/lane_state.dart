import 'package:equatable/equatable.dart';

/// LANE STATE
class LaneState extends Equatable {
  final List<String> swimmers;

  const LaneState(this.swimmers);

  LaneState copyWith({List<String>? swimmers}) {
    return LaneState(swimmers ?? this.swimmers);
  }

  @override
  List<Object> get props => [swimmers];
}
