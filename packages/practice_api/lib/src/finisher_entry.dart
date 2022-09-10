import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part "finisher_entry.g.dart";

// It is smelly to have stroke defined here and in swimmer.dart
// But I dont want to deal with json serializable issues and what not
// The strokes wont change? Maybe could be expanded?
// But later problem :D
enum Stroke {
  @JsonValue("free")
  FREE_STYLE,
  @JsonValue("back")
  BACK_STROKE,
  @JsonValue("breast")
  BREAST_STROKE,
  @JsonValue("fly")
  BUTTERFLY,
}

@JsonSerializable()
@immutable
class FinisherEntry extends Equatable {
  /// The name of the swimmer
  final String name;

  /// The id of the swimmer
  final String id;

  /// The time of the swimmer
  final Duration time;

  /// The stroke the swimmer was swimming
  final Stroke stroke;

  /// The object that stores a swimmer's result after a lap
  const FinisherEntry({
    required this.id,
    required this.name,
    required this.time,
    required this.stroke,
  });

  ///  Deserializes the given [Map] into a [FinisherEntry].
  static FinisherEntry fromJson(Map<String, dynamic> json) =>
      _$FinisherEntryFromJson(json);

  /// Converts this [FinisherEntry] into a [Map]
  Map<String, dynamic> toJson() => _$FinisherEntryToJson(this);

  @override // For equatable
  List<Object> get props => [stroke, id, name, time];

  @override
  String toString() {
    return '{$name : $stroke : $time}';
  }
}
