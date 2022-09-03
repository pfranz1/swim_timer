import 'dart:convert';

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
  LocalStoragePracticeApi({
    required SharedPreferences plugin,
  }) : _plugin = plugin {
    _init();
  }

  final SharedPreferences _plugin;

  final _swimmerStreamController =
      BehaviorSubject<List<Swimmer>>.seeded(const []);

  @visibleForTesting
  static const swimmerCollectionKey = "__swimmers_collection_key__";

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
  int findSwimmer(String id) {
    return _swimmerStreamController.value
        .indexWhere((swimmer) => swimmer.id == id);
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
    final swimmers = _swimmerStreamController.value..removeAt(findSwimmer(id));
    _swimmerStreamController.add(swimmers);
    return _setValue(swimmerCollectionKey, json.encode(swimmers));
  }

  @override
  Future<void> setLane(String id, int? lane) {
    // Make mutable copy of swimmers.
    final swimmers = _swimmerStreamController.value;
    // Find index of desired swimmer.
    final index = findSwimmer(id);

    // If not found throw error.
    if (index == -1) {
      throw SwimmerNotFoundException();
    } else {
      // Make change to found element.
      swimmers[index] = swimmers[index].copyWith(lane: lane);
      // Update stream controller.
      _swimmerStreamController.add(swimmers);
      // Update shared preferences.
      return _setValue(swimmerCollectionKey, json.encode(swimmers));
    }
  }

  @override
  Future<void> setStroke(String id, Stroke stroke) {
    // Make mutable copy of swimmers.
    final swimmers = _swimmerStreamController.value;
    // Find index of desired swimmer.
    final index = findSwimmer(id);

    // If not found throw error.
    if (index == -1) {
      throw SwimmerNotFoundException();
    } else {
      // Make change to found element.
      swimmers[index] = swimmers[index].copyWith(stroke: stroke);
      // Update stream controller.
      _swimmerStreamController.add(swimmers);
      // Update shared preferences.
      return _setValue(swimmerCollectionKey, json.encode(swimmers));
    }
  }

  @override
  Future<void> setStartTime(String id, DateTime? start) {
    // Make mutable copy of swimmers.
    final swimmers = _swimmerStreamController.value;
    // Find index of desired swimmer.
    final index = findSwimmer(id);

    // If not found throw error.
    if (index == -1) {
      throw SwimmerNotFoundException();
    } else {
      // Make change to found element.
      swimmers[index] = swimmers[index].copyWith(startTime: start);
      // Update stream controller.
      _swimmerStreamController.add(swimmers);
      // Update shared preferences.
      return _setValue(swimmerCollectionKey, json.encode(swimmers));
    }
  }

  @override
  Future<void> setEndTime(String id, DateTime? end) {
    // Make mutable copy of swimmers.
    final swimmers = _swimmerStreamController.value;
    // Find index of desired swimmer.
    final index = findSwimmer(id);

    // If not found throw error.
    if (index == -1) {
      throw SwimmerNotFoundException();
    } else {
      // Make change to found element.
      swimmers[index] = swimmers[index].copyWith(endTime: end);
      // Update stream controller.
      _swimmerStreamController.add(swimmers);
      // Update shared preferences.
      return _setValue(swimmerCollectionKey, json.encode(swimmers));
    }
  }
}
