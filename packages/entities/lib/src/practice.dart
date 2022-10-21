// ignore_for_file: public_member_api_docs
import 'package:common/common.dart';
import 'package:entities/entities.dart';

class Practice {
  Practice({
    required String this.title,
  }) {
    ID = Common.idGenerator();
    code = Common.codeGenerator();
  }
  final String title;
  late String code;
  late final String ID;
  late final String date;
  List<Swimmer> swimmers = [];
  List<FinisherEntry> entries = [];
}
