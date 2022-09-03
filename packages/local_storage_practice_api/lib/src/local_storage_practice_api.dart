import 'dart:convert';
import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:practice_api/practice_api.dart';
import 'package:practice_api/src/swimmer.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// {@template local_storage_practice_api}
/// A Flutter implementation of the PracticeApi that uses local storage.
/// {@endtemplate}
class LocalStoragePracticeApi extends PracticeApi {
  /// {@macro local_storage_practice_api}
  LocalStoragePracticeApi({required SharedPreferences plugin})
      : _plugin = plugin {
    _init();
  }

  final SharedPreferences _plugin;

  final _swimmerStreamController =
      BehaviorSubject<List<Swimmer>>.seeded(const []);

  @visibleForTesting

  /// The key used to store swimmer data
  static const swimmerCollectionKey = '__swimmers_collection_key__';

  String? _getValue(String key) => _plugin.getString(key);
  Future<void> _setValue(String key, String value) =>
      _plugin.setString(key, value);

  void _init() {
    final swimmersJson = _getValue(swimmerCollectionKey);
    if (swimmersJson != null) {
      // Convert long nasty jsonString into a swimmer list
      final swimmers =
          List<Map<dynamic, dynamic>>.from(jsonDecode(swimmersJson) as List)
              .map((jsonMap) =>
                  Swimmer.fromJson(Map<String, dynamic>.from(jsonMap)))
              .toList();
      _swimmerStreamController.add(swimmers);
    } else {
      _swimmerStreamController.add(const []);
    }
  }

  /// Find a swimmer by id
  ///
  /// Returns -1 when no swimmer with matching id is found
  int _findSwimmer(String id) {
    return _swimmerStreamController.value
        .indexWhere((swimmer) => swimmer.id == id);
  }

  /// Applies an update function to swimmer by id
  Future<void> _updateSwimmerAndSave(
      String id, Swimmer Function(Swimmer) update) {
    // Get index
    final index = _findSwimmer(id);
    // Make modifiable copy of state
    final swimmers = _swimmerStreamController.value;
    // Update swimmer with passed function
    swimmers[index] = update(swimmers[index]);
    // Update stream controller.
    _swimmerStreamController.add(swimmers);
    // Update shared preferences.
    return _setValue(swimmerCollectionKey, json.encode(swimmers));
  }

  @override
  Stream<List<Swimmer>> getSwimmers() =>
      _swimmerStreamController.asBroadcastStream();

  @override
  Future<void> addSwimmer(Swimmer swimmer) {
    final swimmers = [..._swimmerStreamController.value, swimmer];
    // Update stream
    _swimmerStreamController.add(swimmers);
    // Update local storage
    return _setValue(swimmerCollectionKey, json.encode(swimmers));
  }

  @override
  Future<void> removeSwimmer(String id) {
    final swimmers = _swimmerStreamController.value..removeAt(_findSwimmer(id));
    _swimmerStreamController.add(swimmers);
    return _setValue(swimmerCollectionKey, json.encode(swimmers));
  }

  @override
  Future<void> setLane(String id, int? lane) {
    return _updateSwimmerAndSave(
      id,
      (swimmer) => swimmer.copyWith(lane: lane),
    );
  }

  @override
  Future<void> setStroke(String id, Stroke stroke) {
    return _updateSwimmerAndSave(
      id,
      (swimmer) => swimmer.copyWith(stroke: stroke),
    );
  }

  @override
  Future<void> setStartTime(String id, DateTime? start) {
    return _updateSwimmerAndSave(
      id,
      (swimmer) => swimmer.copyWith(startTime: start),
    );
  }

  @override
  Future<void> setEndTime(String id, DateTime? end) {
    return _updateSwimmerAndSave(
      id,
      (swimmer) => swimmer.copyWith(endTime: end),
    );
  }

  @override
  Future<bool> trySetLane(String id, int lane) async {
    final swimmers = _swimmerStreamController.value;
    // If occupied
    if (swimmers
            .indexWhere((swimmer) => swimmer.lane == lane && swimmer.id != id) >
        -1) {
      throw LaneOccupiedException();
      // Else un-occupied
    } else {
      //TODO: Setting start time to null here will not work as expected, will have no effect
      await _updateSwimmerAndSave(
        id,
        (swimmer) => swimmer.copyWith(lane: lane, startTime: null),
      );
      return true;
    }
  }

  @override
  Future<bool> tryStartSwimmer(String id, DateTime startTime) async {
    final swimmers = _swimmerStreamController.value;
    final index = _findSwimmer(id);

    // If the swimmer in valid lane
    if (swimmers[index].lane != null && swimmers[index].lane! > 0) {
      //TODO: Setting end time to null here will not work as expected, will have no effect
      await _updateSwimmerAndSave(
        id,
        (swimmer) => swimmer.copyWith(startTime: startTime, endTime: null),
      );
      return true;
    } else {
      throw SwimmerNotAssignedLaneException();
    }
  }

  @override
  Future<bool> tryEndSwimmer(String id, DateTime endTime) async {
    final swimmers = _swimmerStreamController.value;
    final index = _findSwimmer(id);

    // If swimmer has started
    if (swimmers[index].startTime != null) {
      await _updateSwimmerAndSave(
        id,
        (p0) => p0.copyWith(
          endTime: endTime,
          lane: 0,
        ),
      );
      return true;
    } else {
      throw SwimmerNotStartedException();
    }
  }
}
