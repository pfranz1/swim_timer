import 'package:firebase_database/firebase_database.dart';
import "package:swim_timer/globals/globals.dart" as globals;
import "package:swim_timer/globals/common.dart" as common;

class DatabaseManager {
  /*
    createPractice(string)

    This method creates a new practice node in DB given the username
    for now it will always reference TestUser
    The practice node is initialized with a:
    >name Child
    >SwimmerList Child
    and is a child itself to an organization
    We can make it so that the user can customize the title
    of the practice as well :)
    @param1: Username of the user
  */
  static Future<void> createPractice(String name) async {
    globals.dbPracticesRef
        .child(name)
        .set({'title': name, 'code': common.codeGenerator()});
  }

  /*
  */
  static String getOrganizationCode(String key) {
    String data = "";
    globals.dbCodeRef.get().then((value) {
      if (value.value != null) {
        data = value.value as String;
      }
    });
    return data;
  }
}
