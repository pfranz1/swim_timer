import "Swimmer.dart";

class Practice {
  String title = "";
  List<Swimmer> swimmerlist = [];
  String code = "";
  late String date;

  Practice(String title) {
    title = title;
    date = DateTime.now().month.toString() +
        "/" +
        DateTime.now().day.toString() +
        "/" +
        DateTime.now().year.toString();
  }

  void addSwimmer(String name) {
    swimmerlist.add(Swimmer(name));
  }
}
