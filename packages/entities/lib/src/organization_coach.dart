// ignore_for_file: public_member_api_docs, unnecessary_this
import 'package:common/common.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

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
}
