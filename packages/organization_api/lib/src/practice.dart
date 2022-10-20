// ignore_for_file: public_member_api_docs
import 'package:organization_api/src/common.dart' as common;

class Practice {
  Practice(
      {required String this.title) {
    ID = common.codeGenerator();
  }
  final String title;
  late String code;
  late final String ID;
  late final String date;
  //List<practice_swimmer> swimmers = [];
  //List<entries> entries = [];
}
