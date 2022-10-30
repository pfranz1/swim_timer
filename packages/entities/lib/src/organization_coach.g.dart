// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization_coach.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrgCoach _$OrgCoachFromJson(Map<String, dynamic> json) => OrgCoach(
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
    )..ID = json['ID'] as String;

Map<String, dynamic> _$OrgCoachToJson(OrgCoach instance) => <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'ID': instance.ID,
    };
