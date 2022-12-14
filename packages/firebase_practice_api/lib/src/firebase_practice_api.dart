// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

// ignore_for_file: omit_local_variable_types, unused_local_variable, lines_longer_than_80_chars, cast_nullable_to_non_nullable

import 'dart:convert';

import 'package:common/common.dart';
// ignore_for_file: public_member_api_docs, type_init_formals

import 'package:entities/entities.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:practice_api/practice_api.dart';

/// {@template firebase_practice_api}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class FirebasePracticeApi extends PracticeApi {
  FirebasePracticeApi({
    required String this.practiceID,
    required String this.orgID,
  }) {
    root = FirebaseDatabase.instance
        .ref()
        .child(orgID)
        .child('Practices')
        .child(practiceID);
  }

  /// {@macro firebase_practice_api}
  final String practiceID;
  final String orgID;
  late final DatabaseReference root;
  //implement whatever
  @override
  Future<void> addSwimmer(Swimmer swimmer) async {
    await root.child('swimmers').child(swimmer.id).set(swimmer.toJson());
  }

  @override
  Stream<Map<String, PracticeResult>> getEntries() {
    throw UnimplementedError();
    // This commented code is for old style of doing backend,
    // the method signature of this function is correct
    /*
    return root
        .child('finisher_entries')
        .orderByKey()
        .onValue
        .asyncMap<List<FinisherEntry>>((event) {
      return (event.snapshot.value as Map<String, String>)
          .values
          .map((entryJSON) {
        final myFinisherEntry = FinisherEntry.fromJson(
          jsonDecode(entryJSON) as Map<String, dynamic>,
        );
        return myFinisherEntry;
      }).toList();
    });
    */
  }

  @override
  Stream<List<Swimmer>> getSwimmers() {
    final DatabaseReference swimmersRef = root.child('swimmers');

    return swimmersRef.orderByKey().onValue.asyncMap<List<Swimmer>>((event) {
      return (event.snapshot.value as Map<String, String>)
          .values
          .map((swimmerJSON) {
        final mySwimmer = Swimmer.fromJson(
          jsonDecode(swimmerJSON) as Map<String, dynamic>,
        );
        return mySwimmer;
      }).toList();
    });
  }

  @override
  Future<void> removeSwimmer(String id) async {
    await root.child(id).remove();
  }

  @override
  Future<bool> resetSwimmer(String id, DateTime startTime, int lane) async {
    await root.child(id).set({'end': '', 'lane': lane, 'start': startTime});
    return true;
  }

  @override
  Future<void> setEndTime(String id, DateTime? end) async {
    if (end != null) {
      await root.child(id).child('end').set(end);
    } else {
      await root.child(id).child('end').set('');
    }
  }

  @override
  Future<void> setLane(String id, int? lane) async {
    if (lane != null) {
      await root.child(id).child('lane').set(lane);
    } else {
      await root.child(id).child('lane').set(0);
    }
  }

  @override
  Future<void> setStartTime(String id, DateTime? start) async {
    if (start != null) {
      await root.child(id).child('start').set(start);
    } else {
      await root.child(id).child('start').set('');
    }
  }

  @override
  Future<void> setStroke(String id, Stroke stroke) async {
    await root.child(id).child('stroke').set(Common.strokeToString[stroke]);
  }

  @override
  Future<bool> tryEndSwimmer(String id, DateTime endTime) async {
    await root.child('swimmers').child(id).child('start').get().then(
          (value) async => {
            if (value.value != null && value.value != '')
              {await root.child('swimmers').child('end').set(endTime)}
            else
              {throw SwimmerNotStartedException()}
          },
        );
    return false;
  }

  @override
  Future<bool> trySetLane(String id, int lane) async {
    bool occupied = false;

/*
    await root
        .child('swimmers')
        .orderByKey().onValue.asyncMap<>((event) => null)
*/

    if (occupied) {
      throw LaneOccupiedException();
    } else {
      await setLane(id, lane);
    }

    throw UnimplementedError();
  }

  @override
  Future<bool> tryStartSwimmer(String id, DateTime startTime) async {
    await root.child('swimmers').child(id).child('lane').get().then(
          (value) async => {
            if (value.value != null && value.value != -1)
              {await root.child('swimmers').child('start').set(startTime)}
            else
              {throw SwimmerNotAssignedLaneException()}
          },
        );
    return false;
  }

  @override
  Future<bool> trySwapLanes({
    required String firstId,
    required int firstLane,
    required String secondId,
    required int secondLane,
  }) async {
    await root.child('swimmers').child(firstId).child('lane').get().then(
          (value) => {if (value.value as int != firstLane) throw SwapFailure()},
        );
    await root.child('swimmers').child(secondId).child('lane').get().then(
          (value) =>
              {if (value.value as int != secondLane) throw SwapFailure()},
        );

    await setLane(firstId, secondLane);
    await setLane(secondId, firstLane);
    return true;
  }

  @override
  Future<bool> undoStart(String id, DateTime? oldEndTime) async {
    await root.child(id).child('start').set('');
    await root.child(id).child('end').set(oldEndTime);
    return true;
  }

  @override
  Future<bool> activatePractice() async {
    await root.child('active').get().then(
      (value) async {
        if (value.value != null && value.value != true) {
          await root.child('active').set(false);
          return true;
        } else {
          throw PracticeAlreadyToggled();
        }
      },
    );
    return false;
  }

  @override
  Future<bool> deactivatePractice() async {
    await root.child('active').get().then(
      (value) async {
        if (value.value != null && value.value != false) {
          await root.child('active').set(true);
          return true;
        } else {
          throw PracticeAlreadyToggled();
        }
      },
    );
    return false;
  }
}
