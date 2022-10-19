// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:organization_api/src/ogranization_swimmer.dart';

/// {@template organization_api}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
abstract class OrganizationApi {
  /// {@macro organization_api}
  const OrganizationApi();

  Future<void> createSwimmer(OrgSwimmer swimmer);
}
