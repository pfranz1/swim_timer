import 'package:firebase_database/firebase_database.dart';

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
    DatabaseReference organizationReference =
        FirebaseDatabase.instance.ref().child("TestOrganization"); //child);

    List<String> emptyList = [];
    emptyList.add("Swimmer 1");
    final String practicekey = "Practice:$name";

    organizationReference
        .child(practicekey)
        .child("name")
        .set(name); //Set value for name node
    organizationReference
        .child(practicekey)
        .child("SwimmerList")
        .set(emptyList); //Initialize swimmer list node
  }

  /*
  */
  static Future<DataSnapshot> getPracticeName(String key) async {
    DatabaseReference dbRef = FirebaseDatabase.instance
        .ref()
        .child("TestOrganization")
        .child("Practice:$key"); //child);

    //final data = new Map
    return dbRef.child("name").get();
  }
}
