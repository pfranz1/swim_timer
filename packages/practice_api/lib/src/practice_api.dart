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
}

/// Error thrown when a [Swimmer] with a given id is not found
class SwimmerNotFoundException implements Exception {}
