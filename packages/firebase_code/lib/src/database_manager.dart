// ignore_for_file: omit_local_variable_types, public_member_api_docs, always_use_package_imports, cast_nullable_to_non_nullable

library database;

import 'package:practice_api/practice_api.dart';

import 'coach.dart';
import 'globals/common.dart' as common;
import 'package:swim_timer/globals.dart' as globals;
import 'practice.dart';

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
    await globals.dbPracticesRef.child(name).set({
      'title': name,
      'code': common.codeGenerator(),
      'date': common.todaysDate()
    });
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
  static Future<void> createSwimmer(String name, String stroke) async {
    final String swimmerID = common.idGenerator();
    await globals.dbOrgRef
        .child('Swimmers')
        .child(swimmerID)
        .set({'name': name, 'id': swimmerID});

    await globals.dbPracticesRef
        .child('Practice1')
        .child('records')
        .child(swimmerID)
        .set({'stroke': stroke, 'id': swimmerID});
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
    String name,
    String email,
    String password,
  ) async {
    await globals.dbCoachesRef.child(name).set({
      'name': name,
      'email': email,
      'password': password,
    });
  }

  /*
    creeateOrganization(String)

    This method creates a new Organization
    >name 
    and is a child itself to the root
    @param1: Creates a new blank organization and generates a unique code
  */

  static Future<void> createOrganization(String orgName) async {
    await globals.dbRootRef
        .child(orgName)
        .set({'Coaches', 'Practices', 'Swimmers', 'code', 'name'});

    await globals.dbRootRef
        .child(orgName)
        .set({'code': common.codeGenerator(), 'name': orgName});
  }

  /*
  retrieves an orgnization's code *MUST AWAIT*
  */
  static Future<String> getOrganizationCode(String key) async {
    String data = '';
    await globals.dbCodeRef.get().then((value) {
      if (value.value != null) {
        data = value.value as String;
      }
    });
    return data;
  }

  /*
  *for testing purposes* retrieves an orgnization's code
  */
  static Future<Swimmer> getSwimmer(String name) async {
    String swimmerName = '';
    String stroke = '';

    await globals.dbSwimmersRef.child('$name/name').get().then((value) {
      if (value.value != null) {
        swimmerName = value.value as String;
      }
    });
    await globals.dbSwimmersRef.child('$name/stroke').get().then((value) {
      if (value.value != null) {
        stroke = value.value as String;
      }
    });
    //await globals.dbSwimmersRef.child('$name/age').get().then((value) {
    //if (value.value != null) {age = value.value as int;}});

    return Swimmer(name: swimmerName);
  }

  static Future<Coach> getCoach(String name) async {
    var coachName = '';
    String email = '';
    String role = '';

    await globals.dbCoachesRef.child('$name/name').get().then((value) {
      if (value.value != null) {
        coachName = value.value as String;
      }
    });
    await globals.dbCoachesRef.child('$name/email').get().then((value) {
      if (value.value != null) {
        email = value.value as String;
      }
    });
    await globals.dbCoachesRef.child('$name/role').get().then((value) {
      if (value.value != null) {
        role = value.value as String;
      }
    });

    return Coach(coachName, email, role);
  }

//  needs work on practice object and getter!!!
  static Future<Practice> getPractice(String title) async {
    String name = '';
    String code = '';
    String date = '';

    await globals.dbPracticesRef.child('$title/title').get().then((value) {
      if (value.value != null) {
        name = value.value as String;
      }
    });
    await globals.dbPracticesRef.child('$title/code').get().then((value) {
      if (value.value != null) {
        code = value.value as String;
      }
    });
    await globals.dbPracticesRef.child('$title/date').get().then((value) {
      if (value.value != null) {
        date = value.value as String;
      }
    });

    return Practice(name, code, date);
  }
}
