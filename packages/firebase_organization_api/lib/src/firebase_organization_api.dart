// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:organization_api/organization_api.dart';
import 'package:firebase_database/firebase_database.dart';

/// {@template firebase_organization_api}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class FirebaseOrganizationApi extends OrganizationApi {
  /// {@macro firebase_organization_api}
  final String orgID;
  late final DatabaseReference root;

  FirebaseOrganizationApi({required String this.orgID}) {
    root = FirebaseDatabase.instance.ref().child(this.orgID);
  }

  Future<void> createSwimmer(OrgSwimmer swimmer) async {
    await root
        .child('Swimmers')
        .child('ID123')
        .set({'name': swimmer.name, 'id': 'ID123'});
  }
}
