//import 'globals.dart' as globals;
class Globals {
  bool loaded = false;
  String username = '';

  Globals() {
    loadGlobals();
  }

  void loadGlobals() async {
    username = "TestUser";
    loaded = true;
    print("Globals Loaded");
  }
}
