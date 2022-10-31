// ignore_for_file: public_member_api_docs, unnecessary_this, type_init_formals
import 'package:common/common.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'organization_coach.g.dart';

@immutable
@JsonSerializable()
class OrgCoach {
  OrgCoach(
      {required String this.name,
      required String this.email,
      required String this.password,
      String? id}) {
    this.ID = id ?? Common.idGenerator();
  }
  final String name;
  final String email;
  final String password;
  late final String ID;
  final String role = '';

  /// Connect the generated [_$OrgCoachFromJson] function to the `fromJson`
  /// factory.
  factory OrgCoach.fromJson(Map<String, dynamic> json) =>
      _$OrgCoachFromJson(json);

  /// Connect the generated [_$OrgCoachToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$OrgCoachToJson(this);
}
