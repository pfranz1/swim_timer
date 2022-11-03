// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lap_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LapResult _$LapResultFromJson(Map<String, dynamic> json) => LapResult(
      stroke: $enumDecode(_$StrokeEnumMap, json['stroke']),
      duration: Duration(microseconds: json['duration'] as int),
      endTime: DateTime.parse(json['endTime'] as String),
    );

Map<String, dynamic> _$LapResultToJson(LapResult instance) => <String, dynamic>{
      'stroke': _$StrokeEnumMap[instance.stroke]!,
      'duration': instance.duration.inMicroseconds,
      'endTime': instance.endTime.toIso8601String(),
    };

const _$StrokeEnumMap = {
  Stroke.FREE_STYLE: 'free',
  Stroke.BACK_STROKE: 'back',
  Stroke.BREAST_STROKE: 'breast',
  Stroke.BUTTERFLY: 'fly',
};
