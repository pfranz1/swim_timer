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
/*
canModifyPractice
canCreatePractice
canDeletePractice
*/
