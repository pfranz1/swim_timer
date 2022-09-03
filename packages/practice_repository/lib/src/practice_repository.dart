import 'package:practice_api/practice_api.dart';

/// {@template practice_repository}
/// A repository that handles pratice related requests.
/// {@endtemplate}
class PracticeRepository {
  /// {@macro practice_repository}
  const PracticeRepository({required PracticeApi practiceApi})
      : _practiceApi = practiceApi;

  final PracticeApi _practiceApi;

  Stream<List<Swimmer>> getSwimmers() => _practiceApi.getSwimmers();

  /// Gets the swimmer who are on the deck
  ///
  /// Specifically, the swimmers in lane 0
  Stream<List<Swimmer>> getDeckSwimmers() =>
      // For every output from Api stream, apply a function to it then return
      _practiceApi.getSwimmers().map((event) {
        // Keep every element that meets criteria then return filtered
        return event.where((element) {
          // Return true, keeping element, if the lane is equal to 0
          return element.lane == 0;
        }).toList();
      });

  // The above function could also be written as using => notation
  // Stream<List<Swimmer>> getDeckSwimmers() => _practiceApi.getSwimmers().map(
  //       (event) => event.where((element) => element.lane == 0).toList(),
  //     );

  /// Gets the swimmers who are the blocks ready to swim next
  ///
  /// Specifically, the swimmers with a lane but with a null start time
  Stream<List<Swimmer>> getBlockSwimmers() => _practiceApi.getSwimmers().map(
        (event) => event
            .where(
                (element) => element.lane != null && element.startTime == null)
            .toList(),
      );

  /// Gets the swimmers who are swimming in the pool
  ///
  /// Specifically, the swimers with a lane and a start time but no end time
  // Maybe good to remove check for a lane, it should be enforced by the api
  // but also maybe just to be safe leave it?
  Stream<List<Swimmer>> getPoolSwimmers() => _practiceApi.getSwimmers().map(
        (event) => event
            .where((element) =>
                element.lane != null &&
                element.startTime != null &&
                element.endTime == null)
            .toList(),
      );

  Future<void> addSwimmer(Swimmer swimmer) => _practiceApi.addSwimmer(swimmer);

  Future<void> removeSwimmer(String id) => _practiceApi.removeSwimmer(id);

  Future<void> setLane(String id, int lane) => _practiceApi.setLane(id, lane);

  Future<void> setStroke(String id, Stroke stroke) =>
      _practiceApi.setStroke(id, stroke);

  Future<void> setStartTime(String id, DateTime start) {
    _practiceApi.setEndTime(id, null);
    return _practiceApi.setStartTime(id, start);
  }

  Future<void> setEndTime(String id, DateTime end) {
    _practiceApi.setLane(id, null);
    return _practiceApi.setEndTime(id, end);
  }
}
