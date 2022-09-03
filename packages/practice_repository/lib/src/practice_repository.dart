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
