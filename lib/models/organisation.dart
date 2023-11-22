// This class is used as the Organisation model class
import 'package:cloud_firestore/cloud_firestore.dart';

class Organisation {
  String? uid;
  String? orgname;
  String? profileURL;
  String? email;
  String? bio;
  String? upiID;
  List<dynamic>? following;  // list of volunteers uids following
  List<dynamic>? volunteerHistory;  // list of event ids
  List<dynamic>? upcomingEvents;  // list of event ids

  Organisation({
    this.uid,
    this.orgname,
    this.email,
    this.profileURL,
    this.bio,
    this.upiID,
    this.following,
    this.volunteerHistory,
    this.upcomingEvents,
  });

  //This function returns a map of data related to the Organisation object
  Map<String, dynamic> getData() => {
        "uid": uid,
        "orgname": orgname,
        "email": email,
        "profileURL": profileURL,
        "location": bio,
        "upiID":upiID,
        "following": following,
        "volunteerHistory": volunteerHistory,
        "upcomingEvents": upcomingEvents,
      };

  //This method returns a Organisation instance based on the document snapshot given by firebase authentication
  static Organisation getOrganisation(DocumentSnapshot snap) {
    Map<String, dynamic> map = snap.data() as Map<String, dynamic>;

    return Organisation(
      uid: map['uid'],
      orgname: map['orgname'],
      email: map['email'],
      profileURL: map['profileURL'],
      bio: map['bio'],
      upiID: map['upiID'],
      following: map['following'],
      volunteerHistory: map['volunteerHistory'],
      upcomingEvents: map['upcomingEvents'],
    );
  }
}