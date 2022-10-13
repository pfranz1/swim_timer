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
    @param1: name of new practice
  */
  static Future<void> createPractice(String name) async {
    globals.dbPracticesRef
        .child(name)
        .set({'title': name, 'code': common.codeGenerator()});
  }

  /*
    createSwimmer(String, int)

    This method creates a new swimmer node in the organization's
    Swimmers node given:
    >name 
    >age
    and is a child itself to an organization
    @param1: Creates a practice in the current global organization
  */
  static Future<void> createSwimmer(String name, int age) async {
    globals.dbOrgRef
        .child("Swimmers")
        .child(name)
        .set({'name': name, 'age': age});
  }

  /*
    createCoach(String, String, String)

    This method creates a new coach node in the organization's
    Coaches node given:
    >name 
    >email
    >password
    and is a child itself to an organization
    @param1: Creates a coach in the organization's coach list
  */
  static Future<void> createCoach(
      String name, String email, String password) async {
    globals.dbCoachesRef
        .child(name)
        .set({'name': name, 'email': email, 'password': password});
  }

  /*
    creeateOrganization(String)

    This method creates a new Organization
    >name 
    and is a child itself to the root
    @param1: Creates a new blank organization and generates a unique code
  */

  static Future<void> createOrganization(String orgName) async {
    globals.dbRootRef
        .child(orgName)
        .set({'Coaches', 'Practices', 'Swimmers', 'code', 'name'});

    globals.dbRootRef
        .child(orgName)
        .set({'code': common.codeGenerator(), 'name': orgName});
  }

  /*
  *for testing purposes* retrieves an orgnization's code
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
