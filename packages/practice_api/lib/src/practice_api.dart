import 'package:entities/entities.dart';

/// {@template practice_api}
/// The interface and models proving accsess to the swimmers durring a practice
/// {@endtemplate}
abstract class PracticeApi {
  /// {@macro practice_api}
  const PracticeApi();

  /// Provides a [Stream] of [Swimmer]s.
  Stream<List<Swimmer>> getSwimmers();

  /// Provides a [Stream] of [FinisherEntry]
  Stream<List<FinisherEntry>> getEntries();

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

  /// Swaps swimmers lanes
  ///
  /// Throws a [SwapFailure] if the swap fails
  Future<bool> trySwapLanes({
    required String firstId,
    required int firstLane,
    required String secondId,
    required int secondLane,
  });

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

  /// Resets an incorrectly stopped swimmer
  Future<bool> resetSwimmer(
    //TODO: Change rest to undo
    String id,
    DateTime startTime,
    int lane,
  );

  // Undoes an incorrectly started swimmer
  Future<bool> undoStart(
    String id,
    DateTime? oldEndTime,
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

///
class SwapFailure implements Exception {}
