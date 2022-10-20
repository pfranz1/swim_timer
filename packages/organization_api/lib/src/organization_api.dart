// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:organization_api/src/organization_swimmer.dart';
import 'package:organization_api/src/organization_coach.dart';

/// {@template organization_api}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
abstract class OrganizationApi {
  /// {@macro organization_api}
  const OrganizationApi();

  Future<void> storeSwimmer(OrgSwimmer swimmer);

  Future<void> storePractice();

  Future<void> storeCoach(OrgCoach coach);

  Future<void> storeOrganization(String name);
}
