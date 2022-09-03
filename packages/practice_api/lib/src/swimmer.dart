// ignore_for_file: public_member_api_docs

import 'package:equatable/equatable.dart';

import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'swimmer.g.dart';

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

  Swimmer copyWith({
    String? id,
    String? name,
    int? lane,
    Stroke? stroke,
    DateTime? startTime,
    DateTime? endTime,
  }) {
    return Swimmer(
      id: id ?? this.id,
      name: name ?? this.name,
      lane: lane ?? this.lane,
      stroke: stroke ?? this.stroke,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
    );
  }

  ///  Deserializes the given [Map] into a [Swimmer].
  static Swimmer fromJson(Map<String, dynamic> json) => _$SwimmerFromJson(json);

  /// Converts this [Swimmer] into a [Map]
  Map<String, dynamic> toJson() => _$SwimmerToJson(this);

  @override // For equatable
  List<Object> get props => [id, name];
}
