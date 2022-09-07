import 'package:practice_api/src/swimmer.dart';

/// {@template practice_api}
/// The interface and models proving accsess to the swimmers durring a practice
/// {@endtemplate}
abstract class PracticeApi {
  /// {@macro practice_api}
  const PracticeApi();

  /// Provides a [Stream] of [Swimmer]s.
  Stream<List<Swimmer>> getSwimmers();

  /// Adds a swimmer to the current swimmers.
  Future<void> addSwimmer(Swimmer swimmer);

  /// Removes a swimmer.
  Future<void> removeSwimmer(String id);

  /// Sets a swimmer to a lane.
  ///
  /// Note: can be null to signal the swimmer isnt assigned a lane
  Future<void> setLane(String id, int? lane);

  /// Sets a swimmers stroke.
  Future<void> setStroke(String id, Stroke stroke);

  /// Sets the start time of a swimmer.
  ///
  /// Note: can be null to reset timing.
  Future<void> setStartTime(String id, DateTime? start);

  /// Sets the end time of a swimmer.
  ///
  /// Note: can be null to reset timing.
  Future<void> setEndTime(String id, DateTime? end);

  /// Sets a swimmers lane if non-occupied lane
  ///
  /// Throws a [LaneOccupiedException] is the lane is occupied
  Future<bool> trySetLane(String id, int lane);

  /// Starts a swimmers lap
  ///
  /// Throws a [SwimmerNotAssignedLaneException] if swimmer is started
  /// without a lane assignment
  Future<bool> tryStartSwimmer(String id, DateTime startTime);

  /// Ends a swimmers lap
  ///
  /// Throws a [SwimmerNotStartedException] if the swimmer hasnt been started yet
  Future<bool> tryEndSwimmer(String id, DateTime endTime);

  /// Resets a incorrectly stopped swimmer
  Future<bool> resetSwimmer(
    String id,
    DateTime startTime,
    int lane,
  );
}

/// Error thrown when a [Swimmer] with a given id is not found
class SwimmerNotFoundException implements Exception {}

/// Error thrown when a [Swimmer] is added to a lane already occupied
class LaneOccupiedException implements Exception {}

/// Error thrown when a [Swimmer] is started without being assinged a lane
class SwimmerNotAssignedLaneException implements Exception {}

/// Error thrown when a [Swimmer] is finished without being already
class SwimmerNotStartedException implements Exception {}
