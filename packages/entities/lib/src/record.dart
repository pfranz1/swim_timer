// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars, unnecessary_this

import 'package:common/common.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

@immutable
@JsonSerializable()
class Record {


  Record({required this.stroke, required this.duration, required this.swimmerID,  String? id})
  {
    this.ID = id ?? Common.idGenerator();
  }
  final String duration;
  late final String ID;
  late final String swimmerID;
  final String stroke;

}
