import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:practice_api/practice_api.dart';
import 'stroke.dart';

part "finisher_entry.g.dart";

@JsonSerializable()
@immutable
class FinisherEntry extends Equatable {
  /// Builds an entry from a swimmer that has all feilds
  factory FinisherEntry.swimmer(Swimmer swimmer) {
    final time = swimmer.endTime!.difference(swimmer.startTime!);
    return FinisherEntry(
      id: swimmer.id,
      name: swimmer.name,
      time: time,
      stroke: swimmer.stroke,
    );
  }

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
