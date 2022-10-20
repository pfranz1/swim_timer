// ignore_for_file: public_member_api_docs

import 'package:organization_api/src/record.dart';
import 'package:organization_api/src/common.dart' as common;

import 'record.dart';

class OrgSwimmer {
  OrgSwimmer({required String this.name, this.records = const []}) {
    ID = common.codeGenerator();
  }
  final String name;
  List<Record> records;
  late final String ID;
}
