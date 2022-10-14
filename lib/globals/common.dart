library common;

import "dart:math";

Map<String, List<bool>> permissions = {
  "head": [true, true, true],
  "stopper": [false, false, false],
  "starter": [false, false, false]
};

String codeGenerator() {
  Random random = Random();
  int randomNumber = random.nextInt(10000) + 1000;
  return randomNumber.toString();
}

String todaysDate()
{
  DateTime now = DateTime.now();
  DateTime date = DateTime(now.year, now.month, now.day);
  String monthdayyear = date.month.toString()+"/"+date.day.toString()+"/"+date.year.toString(); 
  return monthdayyear;
}
/*
canModifyPractice
canCreatePractice
canDeletePractice
*/
