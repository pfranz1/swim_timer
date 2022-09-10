// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finisher_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FinisherEntry _$FinisherEntryFromJson(Map<String, dynamic> json) =>
    FinisherEntry(
      id: json['id'] as String,
      name: json['name'] as String,
      time: Duration(microseconds: json['time'] as int),
      stroke: $enumDecode(_$StrokeEnumMap, json['stroke']),
    );

Map<String, dynamic> _$FinisherEntryToJson(FinisherEntry instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'time': instance.time.inMicroseconds,
      'stroke': _$StrokeEnumMap[instance.stroke]!,
    };

const _$StrokeEnumMap = {
  Stroke.FREE_STYLE: 'free',
  Stroke.BACK_STROKE: 'back',
  Stroke.BREAST_STROKE: 'breast',
  Stroke.BUTTERFLY: 'fly',
};
