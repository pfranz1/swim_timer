import 'package:practice_api/practice_api.dart';

/// {@template practice_repository}
/// A repository that handles pratice related requests.
/// {@endtemplate}
class PracticeRepository {
  /// {@macro practice_repository}
  PracticeRepository({required PracticeApi practiceApi})
      : _practiceApi = practiceApi;

  final PracticeApi _practiceApi;

  String sessionId = "DEFAULTID";

  /// Returns a stream of all the entries the api has
  Stream<List<FinisherEntry>> getEntries() => _practiceApi.getEntries();

  /// Returns a stream of all swimmers the API has
  Stream<List<Swimmer>> getSwimmers() => _practiceApi.getSwimmers();

  /// Applies a filter to all elements of swimmers
  /// filter function should return true to keep the swimmer
  List<Swimmer> _filterSwimmers(
      bool Function(Swimmer) filter, List<Swimmer> swimmers) {
    return swimmers
        .where((Swimmer swimmer) => filter(swimmer) == true)
        .toList();
  }

  /// Gets the swimmers who are on the deck
  ///
  /// Deck Stream
  Stream<List<Swimmer>> getDeckSwimmers() => _practiceApi.getSwimmers().map(
        (event) => _filterSwimmers(_filterDeckSwimmer, event),
      );

  /// TODO: Get swimmers on the deck by idle time
  ///
  /// (idle time = no end time or least recent end time)
  /// note:ask peter abt this hahahaha
  void sortIdleDeckSwimmers(List<Swimmer> swimmers) =>
      swimmers.sort((a, b) => a.endTime!.compareTo(b.endTime!));

  // bool _filterIdleDeckSwimmer(Swimmer swimmer) {
  //   return _filterDeckSwimmer(swimmer) && swimmer.endTime == null;
  // }

  /// Keep if the swimmers lane is 0 or they dont have one
  ///
  /// Deck Filter
  bool _filterDeckSwimmer(Swimmer swimmer) {
    return swimmer.lane == 0 || swimmer.lane == null;
  }

  /// Gets the swimmers who are at the blocks ready to swim next
  ///
  /// Block Stream
  Stream<List<Swimmer>> getBlockSwimmers() => _practiceApi.getSwimmers().map(
        (event) => _filterSwimmers(_filterBlockSwimmer, event),
      );

  /// Keep the swimmer who has a lane > 0 but no start time.
  ///
  /// Block Filter
  bool _filterBlockSwimmer(Swimmer swimmer) {
    return swimmer.lane != null &&
        swimmer.lane != 0 &&
        swimmer.startTime == null;
  }

  /// Gets the swimmers who are swimming in the pool
  ///
  /// Pool Stream
  Stream<List<Swimmer>> getPoolSwimmers() => _practiceApi.getSwimmers().map(
        (event) => _filterSwimmers(_filterPoolSwimmers, event),
      );

  /// Keep if the swimmer has a lane > 0, a start time, but no end time
  ///
  /// Pool Filter
  bool _filterPoolSwimmers(Swimmer swimmer) {
    return swimmer.lane != null &&
        swimmer.lane != 0 &&
        swimmer.startTime != null &&
        swimmer.endTime == null;
  }

  /// Returns a 2-D of swimmers in the pool, Swimmer grouped by lane number
  Stream<List<List<Swimmer>>> getPoolSwimmerByLane() =>
      _practiceApi.getSwimmers().map(
          (event) => _groupByLane(_filterSwimmers(_filterPoolSwimmers, event)));

  /// Groups swimmers into lanes based on their lane numbers
  List<List<Swimmer>> _groupByLane(List<Swimmer> swimmers, {int maxLanes = 6}) {
    //TODO: Set max lanes via some meta data about practice and enforce it

    // Adding 1 to account for lane 0
    final groupings = List.generate(maxLanes + 1, (index) => <Swimmer>[]);

    for (final swimmer in swimmers) {
      final laneNum = swimmer.lane ?? 0;
      groupings[laneNum].add(swimmer);
    }

    return groupings;
  }

  /// Attempts to set the lane of a swimmer
  ///
  /// API defines rules and throws errors when rules violated
  Future<bool> trySetLane(String id, int lane) =>
      _practiceApi.trySetLane(id, lane);

  /// Attempts to start a swimmer
  ///
  /// API defines rules and throws errors when rules violated
  Future<bool> tryStartSwimmer(String id, DateTime startTime) =>
      _practiceApi.tryStartSwimmer(id, startTime);

  /// Attempts to end a swimmers lap
  ///
  /// API defines rules and throws errors when rules violated
  Future<bool> tryEndSwimmer(String id, DateTime endTime) =>
      _practiceApi.tryEndSwimmer(id, endTime);

  /// Swaps Swimmers Lanes
  Future<bool> swapLanes(
      {required String firstId,
      required int firstLane,
      required String secondId,
      required int secondLane}) async {
    return _practiceApi.trySwapLanes(
        firstId: firstId,
        firstLane: firstLane,
        secondId: secondId,
        secondLane: secondLane);
  }

  /// Adds a swimmer
  Future<void> addSwimmer(Swimmer swimmer) => _practiceApi.addSwimmer(swimmer);

  /// Removes a swimmer
  Future<void> removeSwimmer(String id) => _practiceApi.removeSwimmer(id);

  /// Sets a swimmers lane
  ///
  /// Note: Doesnt check any conditions, directly sets it.
  Future<void> setLane(String id, int lane) => _practiceApi.setLane(id, lane);

  /// Sets a swimmers stroke
  Future<void> setStroke(String id, Stroke stroke) =>
      _practiceApi.setStroke(id, stroke);

  /// Sets a swimmers start time
  ///
  /// Note: Doesnt check any conditions, directly sets it
  Future<void> setStartTime(String id, DateTime start) {
    _practiceApi.setEndTime(id, null);
    return _practiceApi.setStartTime(id, start);
  }

  /// Sets a swimmers end time
  ///
  /// Note: Doesnt check any conditions, directly sets it
  Future<void> setEndTime(String id, DateTime end) {
    _practiceApi.setLane(id, null);
    return _practiceApi.setEndTime(id, end);
  }

  Future<void> resetSwimmer(String id, DateTime startTime, int lane) =>
      _practiceApi.resetSwimmer(id, startTime, lane);

  Future<void> undoStart(String id, DateTime? oldEndTime) =>
      _practiceApi.undoStart(id, oldEndTime);
}
