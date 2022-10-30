// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization_swimmer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrgSwimmer _$OrgSwimmerFromJson(Map<String, dynamic> json) => OrgSwimmer(
      name: json['name'] as String,
      records: (json['records'] as List<dynamic>?)
              ?.map((e) => Record.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    )..ID = json['ID'] as String;

Map<String, dynamic> _$OrgSwimmerToJson(OrgSwimmer instance) =>
    <String, dynamic>{
      'name': instance.name,
      'records': instance.records,
      'ID': instance.ID,
    };
