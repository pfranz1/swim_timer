// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'swimmer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Swimmer _$SwimmerFromJson(Map<String, dynamic> json) => Swimmer(
      id: json['id'] as String?,
      name: json['name'] as String,
      lane: json['lane'] as int?,
      stroke: $enumDecodeNullable(_$StrokeEnumMap, json['stroke']),
      startTime: json['startTime'] == null
          ? null
          : DateTime.parse(json['startTime'] as String),
      endTime: json['endTime'] == null
          ? null
          : DateTime.parse(json['endTime'] as String),
    );

Map<String, dynamic> _$SwimmerToJson(Swimmer instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'lane': instance.lane,
      'stroke': _$StrokeEnumMap[instance.stroke]!,
      'startTime': instance.startTime?.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
    };

const _$StrokeEnumMap = {
  Stroke.FREE_STYLE: 'free',
  Stroke.BACK_STROKE: 'back',
  Stroke.BREAST_STROKE: 'breast',
  Stroke.BUTTERFLY: 'fly',
};
