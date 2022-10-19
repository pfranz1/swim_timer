// ignore_for_file: public_member_api_docs

import 'package:organization_api/src/record.dart';

import 'record.dart';

class OrgSwimmer {
  final String name;
  final List<Record> records;

  OrgSwimmer({required String this.name, this.records = const []}) {
    // records = [];
  }
}
