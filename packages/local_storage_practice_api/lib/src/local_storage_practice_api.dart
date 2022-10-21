import 'dart:convert';
import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:practice_api/practice_api.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:entities/entities.dart';

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

  final _entryStreamController =
      BehaviorSubject<List<FinisherEntry>>.seeded(const []);

  @visibleForTesting

  /// The key used to store swimmer data
  static const swimmerCollectionKey = '__swimmers_collection_key__';

  /// The key used to store entry data
  static const entryCollectionKey = '__entry_collection_key__';

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

    final entryJson = _getValue(entryCollectionKey);

    if (entryJson != null) {
      final entries =
          List<Map<dynamic, dynamic>>.from(jsonDecode(entryJson) as List)
              .map((jsonMap) =>
                  FinisherEntry.fromJson(Map<String, dynamic>.from(jsonMap)))
              .toList();
      _entryStreamController.add(entries);
    } else {
      _entryStreamController.add(const []);
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
    // print('New Swimmer state: ${swimmers}');
    return _setValue(swimmerCollectionKey, json.encode(swimmers));
  }

  @override
  Stream<List<Swimmer>> getSwimmers() =>
      _swimmerStreamController.asBroadcastStream();

  @override
  Stream<List<FinisherEntry>> getEntries() =>
      _entryStreamController.asBroadcastStream();

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
      (swimmer) => swimmer.copyWith(startTime: () => start),
    );
  }

  @override
  Future<void> setEndTime(String id, DateTime? end) {
    return _updateSwimmerAndSave(
      id,
      (swimmer) => swimmer.copyWith(endTime: () => end),
    );
  }

  Future<bool> trySwapLanes({
    required String firstId,
    required int firstLane,
    required String secondId,
    required int secondLane,
  }) async {
    // Get index
    final firstIndex = _findSwimmer(firstId);
    final secondIndex = _findSwimmer(secondId);
    // Make modifiable copy of state
    final swimmers = _swimmerStreamController.value;
    // Update swimmers
    swimmers[firstIndex] = swimmers[firstIndex].copyWith(lane: secondLane);
    swimmers[secondIndex] = swimmers[secondIndex].copyWith(lane: firstLane);
    // Update stream controller.
    _swimmerStreamController.add(swimmers);
    // Update shared preferences.
    return _setValue(swimmerCollectionKey, json.encode(swimmers))
        .then((value) => true);
  }

  @override
  Future<bool> trySetLane(String id, int lane) async {
    final swimmers = _swimmerStreamController.value;
    // If occupied
    if (swimmers.indexWhere((swimmer) =>
            swimmer.lane == lane &&
            swimmer.startTime == null &&
            swimmer.id != id) >
        -1) {
      throw LaneOccupiedException();
      // Else un-occupied
    } else {
      await _updateSwimmerAndSave(
        id,
        (swimmer) => swimmer.copyWith(lane: lane, startTime: () => null),
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
      await _updateSwimmerAndSave(
        id,
        (swimmer) => swimmer.copyWith(
          startTime: () => startTime,
          endTime: () => null,
        ),
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
          endTime: () => endTime,
          lane: 0,
        ),
      );
      print(
          "${swimmers[index].name} : ${swimmers[index].stroke} : ${swimmers[index].endTime?.difference(swimmers[index].startTime!)} \n");

      await _saveSwimmerFinisherEntry(swimmers[index]);
      return true;
    } else {
      throw SwimmerNotStartedException();
    }
  }

  Future<void> _saveSwimmerFinisherEntry(Swimmer finisher) {
    // Create new entry
    final newEntry = FinisherEntry.swimmer(finisher);
    // Make growable list and modify it
    final entries = _entryStreamController.value.toList()..add(newEntry);
    // Add entries to stream controller
    _entryStreamController.add(entries);
    // Set value in the storage
    return _setValue(entryCollectionKey, json.encode(entries));
  }

  @override
  Future<bool> resetSwimmer(
    String id,
    DateTime startTime,
    int lane,
  ) async {
    // I dont do any checks / throw exceptions here because
    // I am expecting a swimmer to be rapidly reset.
    // I could be wrong and there need to be checks for this to be valid
    // but i dont think it often arise.

    //TODO: Undo the entry for the swimmer that was reset
    await _updateSwimmerAndSave(
      id,
      (swimmer) => swimmer.copyWith(
        startTime: () => startTime,
        lane: lane,
        endTime: () => null,
      ),
    );

    return true;
  }

  Future<bool> undoStart(
    String id,
    DateTime? oldEndTime,
  ) async {
    await _updateSwimmerAndSave(
      id,
      (swimmer) => swimmer.copyWith(
        endTime: () => oldEndTime,
        startTime: () => null,
      ),
    );

    return true;
  }
}
