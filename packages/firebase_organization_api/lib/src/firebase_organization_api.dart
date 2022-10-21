// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:entities/entities.dart';
import 'package:common/common.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:organization_api/organization_api.dart';

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
  Future<void> storePractice(Practice practice) async {
    await root.child('Practices').child(practice.ID).set({
      'id': practice.ID,
      'title': practice.title,
      'code': practice.code,
      //'active': practice.active,
      /*
      'date': {
        'day': practice.date.day,
        'month': practice.date.month,
        'year': practice.date.year,
      }
      */
    });
  }

  @override
  Future<void> storeOrganization(String name) async {
    final orgID = Common.idGenerator();
    await FirebaseDatabase.instance
        .ref()
        .child(orgID)
        .child('name')
        .set(name); //create name
    await FirebaseDatabase.instance
        .ref()
        .child(orgID)
        .child('code')
        .set(Common.codeGenerator());
    await FirebaseDatabase.instance
        .ref()
        .child(orgID)
        .child('id')
        .set(Common.idGenerator());
  }
}
