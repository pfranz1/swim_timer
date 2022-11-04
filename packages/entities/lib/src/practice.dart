// ignore_for_file: public_member_api_docs, unnecessary_this, lines_longer_than_80_chars
import 'package:common/common.dart';
import 'package:entities/entities.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'practice.g.dart';

@immutable
@JsonSerializable()
class Practice {
  Practice({
    required this.title,
    required this.lanes,
    String? id,
    String? code,
    DateTime? date,
    List<FinisherEntry>? finisher_entries,
    List<Swimmer>? swimmers,
  }) {
    this.ID = id ?? Common.idGenerator();
    this.code = code ?? Common.codeGenerator();
    this.date = date ?? Common.todaysDate();
    this.active = true;
    this.finisher_entries = finisher_entries ?? [];
    this.swimmers = swimmers ?? [];
  }
  final String title;
  late String code;
  late bool active;
  late final String ID;
  late final DateTime date;
  final int lanes;
  List<Swimmer> swimmers = [];
  List<FinisherEntry> finisher_entries = [];

  /// Connect the generated [_$PracticeFromJson] function to the `fromJson`
  /// factory.
  factory Practice.fromJson(Map<String, dynamic> json) =>
      _$PracticeFromJson(json);

  /// Connect the generated [_$PracticeToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$PracticeToJson(this);
}
