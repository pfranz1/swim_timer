import 'package:entities/entities.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'lap_result.g.dart';

@JsonSerializable()
@immutable

/// LapResult is the minimum data stored for a lap,
/// It does NOT identify who swam it (stored in the containing object)
class LapResult extends Equatable {
  /// Constructor
  const LapResult({
    required this.stroke,
    required this.duration,
    required this.endTime,
  });

  /// Creates a lap result from a swimmer that has just finished
  ///
  /// will cause null invocations if swimmer doesn't have felids expected
  /// of a swimmer that just swam
  factory LapResult.fromSwimmer(Swimmer swimmer) {
    return LapResult(
      stroke: swimmer.stroke,
      duration: swimmer.endTime!.difference(swimmer.startTime!),
      endTime: swimmer.endTime!,
    );
  }

  /// Stroke that was swam
  final Stroke stroke;

  /// Time it took swimmer to swim lap
  final Duration duration;

  /// The date+time when they finished swimming
  final DateTime endTime;

  ///  Deserializes the given [Map] into a [LapResult].
  static LapResult fromJson(Map<String, dynamic> json) =>
      _$LapResultFromJson(json);

  /// Converts this [LapResult] into a [Map]
  Map<String, dynamic> toJson() => _$LapResultToJson(this);

  /// Returns props for equatable
  @override
  List<Object> get props => [stroke, duration, endTime];
}
