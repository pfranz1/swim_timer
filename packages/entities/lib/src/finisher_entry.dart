import 'package:entities/src/stroke.dart';
import 'package:entities/src/swimmer.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'finisher_entry.g.dart';

/// The role of this object is for the front end tiles that show a swimmers
/// stats for a lap during a practice

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

  /// The DateTime the time was achieved
  final DateTime dateAchieved;

  /// The previous times of the swimmer
  final List<Duration>? previousTimes;

  /// The difference in time between the current achieved time and previously
  /// achieved time
  ///
  ///
  /// difference > 0 => the time was slower
  /// difference < 0 => the time was faster
  /// (current time - last time);
  final double? differenceWithLastTime;

  /// The object that stores a swimmer's result after a lap
  const FinisherEntry({
    required this.id,
    required this.name,
    required this.time,
    required this.stroke,
    required this.dateAchieved,
    this.differenceWithLastTime,
    this.previousTimes,
  });

  ///  Deserializes the given [Map] into a [FinisherEntry].
  static FinisherEntry fromJson(Map<String, dynamic> json) =>
      _$FinisherEntryFromJson(json);

  /// Converts this [FinisherEntry] into a [Map]
  Map<String, dynamic> toJson() => _$FinisherEntryToJson(this);

  @override // For equatable
  List<Object?> get props =>
      [stroke, id, name, time, dateAchieved, differenceWithLastTime];

  @override
  String toString() {
    return '{$name : $stroke : $time}';
  }
}
