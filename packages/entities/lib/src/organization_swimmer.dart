// ignore: lines_longer_than_80_chars
// ignore_for_file: public_member_api_docs, unnecessary_this, type_init_formals, non_constant_identifier_names

import 'package:common/common.dart';
import 'package:entities/src/record.dart';

class OrgSwimmer {
  OrgSwimmer({required String this.name, String? id, this.records = const []}) {
    if (id == null) {
      this.ID = Common.codeGenerator();
    } else {
      this.ID = id;
    }
  }
  final String name;
  List<Record> records;
  late final String ID;
}
