// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Record _$RecordFromJson(Map<String, dynamic> json) => Record(
      stroke: json['stroke'] as String,
      duration: json['duration'] as String,
      swimmerID: json['swimmerID'] as String,
    )..ID = json['ID'] as String;

Map<String, dynamic> _$RecordToJson(Record instance) => <String, dynamic>{
      'duration': instance.duration,
      'ID': instance.ID,
      'swimmerID': instance.swimmerID,
      'stroke': instance.stroke,
    };
