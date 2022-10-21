// ignore_for_file: public_member_api_docs

import 'package:common/common.dart';
import 'package:entities/src/record.dart';

class OrgSwimmer {
  OrgSwimmer({required String this.name, this.records = const []}) {
    ID = Common.codeGenerator();
  }
  final String name;
  List<Record> records;
  late final String ID;
}
