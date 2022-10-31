// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'practice_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PracticeResult _$PracticeResultFromJson(Map<String, dynamic> json) =>
    PracticeResult(
      swimmerId: json['swimmerId'] as String,
      swimmerName: json['swimmerName'] as String,
      meters: json['meters'] as int,
      lapResults: (json['lapResults'] as List<dynamic>)
          .map((e) => LapResult.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PracticeResultToJson(PracticeResult instance) =>
    <String, dynamic>{
      'swimmerId': instance.swimmerId,
      'swimmerName': instance.swimmerName,
      'meters': instance.meters,
      'lapResults': instance.lapResults,
    };
