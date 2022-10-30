import 'package:entities/src/stroke.dart';
import 'package:entities/src/swimmer.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'finisher_entry.g.dart';

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
      dateAchieved: swimmer.endTime!,
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

  /// The DateTime the time was achieved
  final DateTime dateAchieved;

  /// The object that stores a swimmer's result after a lap
  const FinisherEntry({
    required this.id,
    required this.name,
    required this.time,
    required this.stroke,
    required this.dateAchieved,
  });

  ///  Deserializes the given [Map] into a [FinisherEntry].
  static FinisherEntry fromJson(Map<String, dynamic> json) =>
      _$FinisherEntryFromJson(json);

  /// Converts this [FinisherEntry] into a [Map]
  Map<String, dynamic> toJson() => _$FinisherEntryToJson(this);

  @override // For equatable
  List<Object> get props => [stroke, id, name, time, dateAchieved];

  @override
  String toString() {
    return '{$name : $stroke : $time}';
  }
}
