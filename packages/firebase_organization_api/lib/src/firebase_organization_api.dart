// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

// ignore_for_file: omit_local_variable_types, prefer_final_locals, cast_nullable_to_non_nullable, lines_longer_than_80_chars
import 'dart:convert';
import 'package:common/common.dart';
import 'package:entities/entities.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:organization_api/organization_api.dart';

/// {@template firebase_organization_api}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class FirebaseOrganizationApi extends OrganizationApi {
  // ignore: lines_longer_than_80_chars
  ///Constructor: initializes the root reference given the organization ID as a String
  FirebaseOrganizationApi({required this.orgID}) {
    root = FirebaseDatabase.instance.ref().child(orgID);
  }

  /// {@macro firebase_organization_api}
  final String orgID;

  /// root: reference to the provided organization node
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
    final DatabaseReference practicesRef = root.child('Practices');

    return practicesRef.orderByKey().onValue.asyncMap<List<Practice>>((event) {
      return (event.snapshot.value as Map<String, String>)
          .values
          .map((practiceJSON) {
        final myPractice = Practice.fromJson(
          jsonDecode(practiceJSON) as Map<String, dynamic>,
        );
        return myPractice;
      }).toList();
    });
  }

  @override
  Stream<List<OrgCoach>> getCoaches() {
    final DatabaseReference coachesRef = root.child('Coaches');

    return coachesRef.orderByKey().onValue.asyncMap<List<OrgCoach>>((event) {
      return (event.snapshot.value as Map<String, String>)
          .values
          .map((orgcoachJSON) {
        final myOrgCoach = OrgCoach.fromJson(
          jsonDecode(orgcoachJSON) as Map<String, dynamic>,
        );
        return myOrgCoach;
      }).toList();
    });
  }

  @override
  Stream<List<OrgSwimmer>> getOrganizationSwimmers() {
    final DatabaseReference swimmersRef = root.child('Swimmers');

    return swimmersRef.orderByKey().onValue.asyncMap<List<OrgSwimmer>>((event) {
      return (event.snapshot.value as Map<String, String>)
          .values
          .map((orgswimmerJSON) {
        final myOrgSwimmer = OrgSwimmer.fromJson(
          jsonDecode(orgswimmerJSON) as Map<String, dynamic>,
        );
        return myOrgSwimmer;
      }).toList();
    });
  }

  @override
  Stream<List<Practice>> getPractices() {
    final DatabaseReference practicesRef = root.child('Practices');

    return practicesRef.orderByKey().onValue.asyncMap<List<Practice>>((event) {
      return (event.snapshot.value as Map<String, String>)
          .values
          .map((practiceJSON) {
        final myPractice = Practice.fromJson(
          jsonDecode(practiceJSON) as Map<String, dynamic>,
        );
        return myPractice;
      }).toList();
    });
  }

  @override
  Stream<List<PracticeResult>> getRecords() {
    final DatabaseReference practicesRef = root.child('Practices');
/*
    return practicesRef
        .orderByKey()
        .onValue
        .asyncMap<List<FinisherEntry>>((event) {
      return (event.snapshot.value as Map<String, String>)
          .map((practiceJSON) {
        var myPractice = Practice.fromJson(
            (jsonDecode(practiceJSON) as Map<String, dynamic>));

        return myEntries;
      }).toList();
    });
    */
    throw UnimplementedError();
  }
}
