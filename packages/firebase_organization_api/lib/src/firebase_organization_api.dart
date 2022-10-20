// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:organization_api/src/organization_swimmer.dart';
import 'package:organization_api/src/organization_coach.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:organization_api/organization_api.dart';
import 'package:organization_api/src/common.dart' as common;

/// {@template firebase_organization_api}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class FirebaseOrganizationApi extends OrganizationApi {
  FirebaseOrganizationApi({required String this.orgID}) {
    root = FirebaseDatabase.instance.ref().child(orgID);
  }

  /// {@macro firebase_organization_api}
  final String orgID;
  late final DatabaseReference root;

  @override
  Future<void> storeSwimmer(OrgSwimmer swimmer) async {
    await root
        .child('Swimmers')
        .child(swimmer.ID)
        .set({'name': swimmer.name, 'id': swimmer.ID});
  }

  @override
  Future<void> storeCoach(OrgCoach coach) async {
    await root.child('Coaches').child(coach.ID).set({
      'name': coach.name,
      'id': coach.ID,
      'email': coach.email,
      'role': coach.role,
      'password': coach.password
    });
  }

  @override
  Future<void> storePractice() {
    // TODO: implement createPractice
    throw UnimplementedError();
  }

  @override
  Future<void> storeOrganization(String name) async {
    final orgID = common.idGenerator();
    await FirebaseDatabase.instance
        .ref()
        .child(orgID)
        .child('name')
        .set(name); //create name
    await FirebaseDatabase.instance
        .ref()
        .child(orgID)
        .child('code')
        .set(common.codeGenerator());
    await FirebaseDatabase.instance
        .ref()
        .child(orgID)
        .child('id')
        .set(common.idGenerator());
  }
}
