// ignore_for_file: public_member_api_docs
import 'package:common/common.dart';

class Practice {
  Practice({
    required String this.title,
  }) {
    ID = Common.codeGenerator();
  }
  final String title;
  late String code;
  late final String ID;
  late final String date;
  //List<practice_swimmer> swimmers = [];
  //List<entries> entries = [];
}
