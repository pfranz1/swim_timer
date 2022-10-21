// ignore_for_file: public_member_api_docs
import 'package:common/common.dart';

class OrgCoach {
  OrgCoach(
      {required String this.name,
      required String this.email,
      required String this.password}) {
    ID = Common.codeGenerator();
  }
  final String name;
  final String email;
  final String password;
  late final String ID;
  final String role = '';
}
