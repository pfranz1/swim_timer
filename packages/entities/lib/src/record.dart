// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars, unnecessary_this

import 'package:common/common.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'record.g.dart';

@immutable
@JsonSerializable()
class Record {
  Record(
      {required this.stroke,
      required this.duration,
      required this.swimmerID,
      String? id}) {
    this.ID = id ?? Common.idGenerator();
  }
  final String duration;
  late final String ID;
  late final String swimmerID;
  final String stroke;

  /// Connect the generated [_$RecordFromJson] function to the `fromJson`
  /// factory.
  factory Record.fromJson(Map<String, dynamic> json) => _$RecordFromJson(json);

  /// Connect the generated [_$RecordToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$RecordToJson(this);
}
