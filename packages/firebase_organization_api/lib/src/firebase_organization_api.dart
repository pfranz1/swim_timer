// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:html';

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
      'lanes': practice.lanes,
      'active': practice.active,
    });

    await root
        .child('Practices')
        .child(practice.ID)
        .child('date')
        .set(practice.date);
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

  @override
  Future<void> removeCoach(String id) async {
    await root.child('Coaches').child(id).remove();
  }

  @override
  Future<void> removePractice(String id) async {
    await root.child('Practices').child(id).remove();
  }

  @override
  Future<void> removeSwimmer(String id) async {
    await root.child('Swimmers').child(id).remove();
  }

  @override
  Stream<List<Practice>> getActivePractices() {
    // TODO: implement getActivePractices
    throw UnimplementedError();
  }

  @override
  Stream<List<OrgCoach>> getCoaches() {
    // TODO: implement getCoaches
    throw UnimplementedError();
  }

  @override
  Stream<List<OrgSwimmer>> getOrganizationSwimmers() {
    // TODO: implement getOrganizationSwimmers
    throw UnimplementedError();
  }

  @override
  Stream<List<Practice>> getPractices() {
    // TODO: implement getPractices
    throw UnimplementedError();
  }

  @override
  Stream<List<Entry>> getRecords() {
    // TODO: implement getRecords
    throw UnimplementedError();
  }
}
