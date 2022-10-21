// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

// ignore_for_file: public_member_api_docs

import 'package:firebase_practice_api/firebase_practice_api.dart';
import 'package:practice_api/practice_api.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:entities/entities.dart';

/// {@template firebase_practice_api}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class FirebasePracticeApi extends PracticeApi {
  FirebasePracticeApi({
    required String this.practiceID,
    required String this.orgID,
  }) {
    root = FirebaseDatabase.instance.ref().child(orgID).child(practiceID);
  }

  /// {@macro firebase_practice_api}
  final String practiceID;
  final String orgID;
  late final DatabaseReference root;
  //implement whatever
  Future<void> addSwimmer(Swimmer swimmer) async {
    await root.child('swimmers').child(swimmer.id).set(swimmer.toJson());
  }

  @override
  Stream<List<FinisherEntry>> getEntries() {
    // TODO: implement getEntries
    throw UnimplementedError();
  }

  @override
  Stream<List<Swimmer>> getSwimmers() {
    // TODO: implement getSwimmers
    throw UnimplementedError();
  }

  @override
  Future<void> removeSwimmer(String id) {
    // TODO: implement removeSwimmer
    throw UnimplementedError();
  }

  @override
  Future<bool> resetSwimmer(String id, DateTime startTime, int lane) {
    // TODO: implement resetSwimmer
    throw UnimplementedError();
  }

  @override
  Future<void> setEndTime(String id, DateTime? end) {
    // TODO: implement setEndTime
    throw UnimplementedError();
  }

  @override
  Future<void> setLane(String id, int? lane) {
    // TODO: implement setLane
    throw UnimplementedError();
  }

  @override
  Future<void> setStartTime(String id, DateTime? start) {
    // TODO: implement setStartTime
    throw UnimplementedError();
  }

  @override
  Future<void> setStroke(String id, Stroke stroke) {
    // TODO: implement setStroke
    throw UnimplementedError();
  }

  @override
  Future<bool> tryEndSwimmer(String id, DateTime endTime) {
    // TODO: implement tryEndSwimmer
    throw UnimplementedError();
  }

  @override
  Future<bool> trySetLane(String id, int lane) {
    // TODO: implement trySetLane
    throw UnimplementedError();
  }

  @override
  Future<bool> tryStartSwimmer(String id, DateTime startTime) {
    // TODO: implement tryStartSwimmer
    throw UnimplementedError();
  }

  @override
  Future<bool> trySwapLanes(
      {required String firstId,
      required int firstLane,
      required String secondId,
      required int secondLane}) {
    // TODO: implement trySwapLanes
    throw UnimplementedError();
  }

  @override
  Future<bool> undoStart(String id, DateTime? oldEndTime) {
    // TODO: implement undoStart
    throw UnimplementedError();
  }
}
