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
DatabaseReference dbSwimmersRef = FirebaseDatabase.instance.ref();
DatabaseReference dbRootRef = FirebaseDatabase.instance.ref();

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

    dbCodeRef = dbRootRef.child("$organization/Code");
    dbNameRef = dbRootRef.child("$organization/Name");
    dbOrgRef = dbRootRef.child(organization);
    dbPracticesRef =
        dbRootRef.child("$organization/Practices");
    dbCoachesRef =
        dbRootRef.child("$organization/Coaches");
    dbSwimmersRef = dbRootRef.child("$organization/Swimmers");
    
  }
}
