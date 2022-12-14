// ignore: lines_longer_than_80_chars
// ignore_for_file: public_member_api_docs, unnecessary_this, type_init_formals, non_constant_identifier_names

import 'package:common/common.dart';
import 'package:entities/src/record.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'organization_swimmer.g.dart';

@immutable
@JsonSerializable()
class OrgSwimmer {
  OrgSwimmer({required String this.name, String? id, this.records = const []}) {
    this.ID = id ?? Common.idGenerator();
  }
  final String name;
  List<Record> records;
  late final String ID;

  /// Connect the generated [_$OrgSwimmerFromJson] function to the `fromJson`
  /// factory.
  factory OrgSwimmer.fromJson(Map<String, dynamic> json) =>
      _$OrgSwimmerFromJson(json);

  /// Connect the generated [_$OrgSwimmerToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$OrgSwimmerToJson(this);
}
