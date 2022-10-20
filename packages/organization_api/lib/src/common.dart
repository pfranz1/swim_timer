// ignore_for_file: omit_local_variable_types

library common;

import 'package:uuid/uuid.dart';

Map<String, List<bool>> permissions = {
  'head': [true, true, true],
  'stopper': [false, false, false],
  'starter': [false, false, false]
};

String codeGenerator() {
  final uuid = Uuid();
  String code = uuid.v1();
  return code.substring(0, 7);
}

String idGenerator() {
  final uuid = Uuid();
  return uuid.v1();
}

String todaysDate() {
  final DateTime now = DateTime.now();
  final DateTime date = DateTime(now.year, now.month, now.day);
  final String monthdayyear = '${date.month}/${date.day}/${date.year}';
  return monthdayyear;
}
