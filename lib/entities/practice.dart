import "package:swim_timer/entities/swimmer.dart";

class Practice {
  late String title = "";
  List<Swimmer> swimmerlist = [];
  late String code = "";
  late String date;

  Practice(String title, String code, String date) {
    this.title = title;this.code=code;this.date=date;
  }
}
