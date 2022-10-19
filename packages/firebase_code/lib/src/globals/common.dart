// ignore_for_file: omit_local_variable_types, public_member_api_docs

library common;

import 'dart:math';

Map<String, List<bool>> permissions = {
  'head': [true, true, true],
  'stopper': [false, false, false],
  'starter': [false, false, false]
};

String codeGenerator() {
  final Random random = Random();
  final int randomNumber = random.nextInt(10000) + 1000;
  return randomNumber.toString();
}

String idGenerator() {
  final Random random = Random();
  final int randomNumber = random.nextInt(100000) + 10000;
  return 'ID$randomNumber';
}

String todaysDate() {
  final DateTime now = DateTime.now();
  final DateTime date = DateTime(now.year, now.month, now.day);
  final String monthdayyear = '${date.month}/${date.day}/${date.year}';
  return monthdayyear;
}
/*
canModifyPractice
canCreatePractice
canDeletePractice
*/
