import 'package:entities/entities.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'practice_result.g.dart';

@JsonSerializable()
@immutable
class PracticeResult extends Equatable {
  /// Id of swimmer
  final String swimmerId;

  /// Name of swimmer
  final String swimmerName;

  /// Number of meeters that the practice was based around
  final int meters;

  /// Results of laps that the swimmer swam
  final List<LapResult> lapResults;

  const PracticeResult({
    required this.swimmerId,
    required this.swimmerName,
    required this.meters,
    required this.lapResults,
  });

  PracticeResult addLapResult(LapResult newLapResult) {
    return PracticeResult(
      swimmerId: swimmerId,
      swimmerName: swimmerName,
      meters: meters,
      lapResults: lapResults..add(newLapResult),
    );
  }

  ///  Deserializes the given [Map] into a [PracticeResult].
  static PracticeResult fromJson(Map<String, dynamic> json) =>
      _$PracticeResultFromJson(json);

  /// Converts this [PracticeResult] into a [Map]
  Map<String, dynamic> toJson() => _$PracticeResultToJson(this);

  List<Object?> get props => [swimmerId, swimmerName, meters, lapResults];
}
