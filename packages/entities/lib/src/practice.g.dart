// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'practice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Practice _$PracticeFromJson(Map<String, dynamic> json) => Practice(
      title: json['title'] as String,
      lanes: json['lanes'] as int,
      code: json['code'] as String?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      finisher_entries: (json['finisher_entries'] as List<dynamic>?)
          ?.map((e) => FinisherEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
      swimmers: (json['swimmers'] as List<dynamic>?)
          ?.map((e) => Swimmer.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..active = json['active'] as bool
      ..ID = json['ID'] as String;

Map<String, dynamic> _$PracticeToJson(Practice instance) => <String, dynamic>{
      'title': instance.title,
      'code': instance.code,
      'active': instance.active,
      'ID': instance.ID,
      'date': instance.date.toIso8601String(),
      'lanes': instance.lanes,
      'swimmers': instance.swimmers,
      'finisher_entries': instance.finisher_entries,
    };
