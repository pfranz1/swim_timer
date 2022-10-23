// ignore_for_file: public_member_api_docs
import 'package:common/common.dart';
import 'package:entities/entities.dart';

class Practice {
  Practice({required this.title, required this.lanes}) {
    ID = Common.idGenerator();
    code = Common.codeGenerator();
    date = Common.todaysDate();
  }
  final String title;
  late String code;
  bool active = true;
  late final String ID;
  late final DateTime date;
  final int lanes;
  List<Swimmer> swimmers = [];
  List<FinisherEntry> entries = [];
}
