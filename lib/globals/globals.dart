library globals;

import 'package:firebase_database/firebase_database.dart';

bool loaded = false;
String coach = '';
String organization = '';
DatabaseReference dbOrgRef = FirebaseDatabase.instance.ref();
DatabaseReference dbPracticesRef = FirebaseDatabase.instance.ref();
DatabaseReference dbCoachesRef = FirebaseDatabase.instance.ref();
DatabaseReference dbCodeRef = FirebaseDatabase.instance.ref();
DatabaseReference dbNameRef = FirebaseDatabase.instance.ref();

class Globals {
  Globals();

  static Future<void> initGlobals() async {
    loaded = false;
    coach = '';
    organization = '';
  }

  static Future<void> loadGlobals() async {
    loaded = true;
    coach = "Coach1";
    organization = "Organization1";

    dbCodeRef = FirebaseDatabase.instance.ref().child("$organization/Code");
    dbNameRef = FirebaseDatabase.instance.ref().child("$organization/Name");
    dbOrgRef = FirebaseDatabase.instance.ref().child(organization);
    dbPracticesRef =
        FirebaseDatabase.instance.ref().child("$organization/Practices");
    dbCoachesRef =
        FirebaseDatabase.instance.ref().child("$organization/Coaches");
  }
}
