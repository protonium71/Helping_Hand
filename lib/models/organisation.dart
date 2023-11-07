// This class is used as the Organisation model class
import 'package:cloud_firestore/cloud_firestore.dart';

class Organisation {
  String? uid;
  String? orgname;
  String? profileURL;
  String? email;
  String? bio;
  String? following;
  List<String> volunteerHistory = [];  // list of job ids
  List<String> upcomingEvents = [];  // list of job ids

  Organisation({
    this.uid,
    this.orgname,
    this.email,
    this.profileURL,
    this.bio,
    this.following,
    required this.volunteerHistory,
    required this.upcomingEvents,
  });

  //This function returns a map of data related to the Organisation object
  Map<String, dynamic> getData() => {
        "uid": uid,
        "orgname": orgname,
        "email": email,
        "profileURL": profileURL,
        "location": bio,
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
      following: map['following'],
      volunteerHistory: map['volunteerHistory'],
      upcomingEvents: map['upcomingEvents'],
    );
  }
}