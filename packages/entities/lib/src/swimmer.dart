// ignore_for_file: public_member_api_docs

import 'package:entities/src/stroke.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'swimmer.g.dart';

@immutable
@JsonSerializable()
class Swimmer extends Equatable {
  Swimmer({
    String? id,
    required this.name,
    this.lane,
    Stroke? stroke,
    this.startTime,
    this.endTime,
  })  : id = id ?? const Uuid().v4(),
        stroke = stroke ?? Stroke.FREE_STYLE;

  /// The unique identifier of the swimmer.
  final String id;

  /// The name of the swimmer.
  final String name;

  /// The lane the swimmer is in.
  ///
  /// is null when the swimmer is on the deck
  final int? lane;

  /// The stoke style the swimmer is going to do
  ///
  /// defaults to freestyle
  final Stroke stroke;

  /// The time the swimmer left the starting position.
  ///
  /// is null when the swimmer is on the deck or lined up
  final DateTime? startTime;

  /// The time the swimmer touched the wall to finish the lap.
  ///
  /// is null when a swimmer is swimming
  final DateTime? endTime;

  // If you wanted to know why im using this aproach for copyWith
  // I use current function notation instead of ValueGetters
  // https://stackoverflow.com/a/73432242
  // Basically I cant pass "null" directly to set startTime to null because
  // the input parameter will be null if I pass nothing and also when I pass null
  // So I need a better way to tell flutter to explicitly set it to null
  // I do this by passing a function that returns what I want to set the value to

  Swimmer copyWith({
    String? id,
    String? name,
    int? lane,
    Stroke? stroke,
    DateTime? Function()? startTime,
    DateTime? Function()? endTime,
  }) {
    return Swimmer(
      id: id ?? this.id,
      name: name ?? this.name,
      lane: lane ?? this.lane,
      stroke: stroke ?? this.stroke,
      startTime: startTime != null ? startTime() : this.startTime,
      endTime: endTime != null ? endTime() : this.endTime,
    );
  }

  ///  Deserializes the given [Map] into a [Swimmer].
  static Swimmer fromJson(Map<String, dynamic> json) => _$SwimmerFromJson(json);

  /// Converts this [Swimmer] into a [Map]
  Map<String, dynamic> toJson() => _$SwimmerToJson(this);

  @override // For equatable
  List<Object?> get props => [id, name, lane, stroke];

  /// Compares swimmers and returns a positive number if a is dryer than b
  ///
  /// Assume that start time is before end time.
  /// Assume that if end time is null, so is start time.
  static int compareMostDry(Swimmer a, Swimmer b) {
    // If both people haven't swam yet
    if (a.endTime == null && b.endTime == null) {
      return a.name.compareTo(b.name);
    }
    // If one person hasn't swam yet
    else if (a.endTime == null || b.endTime == null) {
      // most dry person will be the person with no end time yet
      return a.endTime == null ? -1 : 1;
    }
    // If both people have swam
    else {
      return a.endTime!.compareTo(b.endTime!);
    }
  }

  @override
  String toString() {
    return "{$name : $stroke : $lane}";
  }
}
