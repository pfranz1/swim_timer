// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

// ignore_for_file: omit_local_variable_types

/// {@template common}
/// Common
/// {@endtemplate}
import 'package:entities/entities.dart';
import 'package:uuid/uuid.dart';

class Common {
  /// {@macro common}

  static String codeGenerator() {
    const uuid = Uuid();
    final String code = uuid.v4();
    return code.substring(0, 7);
  }

  static String idGenerator() {
    const uuid = Uuid();
    return uuid.v4();
  }

  static DateTime todaysDate() {
    final DateTime now = DateTime.now();
    return now;
  }

  static Map<Stroke, String> strokeToString = {
    Stroke.FREE_STYLE: 'Free',
    Stroke.BACK_STROKE: 'Back',
    Stroke.BREAST_STROKE: 'Breast',
    Stroke.BUTTERFLY: 'Fly'
  };

  //todo: fix and document this
  static Map<String, List<bool>> permissions = {
    'head': [true, true, true],
    'stopper': [false, false, false],
    'starter': [false, false, false]
  };
}
