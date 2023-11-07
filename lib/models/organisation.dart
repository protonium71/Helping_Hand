// This class is used as the Organisation model class
import 'package:cloud_firestore/cloud_firestore.dart';

class Organisation {
  String? uid;
  String? orgName;
  String? profileURL;
  String? email;
  String? bio;
  String? following;
  List<String> interests = [];
  List<String> skills = [];
  List<String> volunteerHistory = [];  // list of job ids
  List<String> upcomingEvents = [];  // list of job ids

  Organisation({
    this.uid,
    this.orgName,
    this.email,
    this.profileURL,
    this.bio,
    this.following,
    required this.interests,
    required this.skills,
    required this.volunteerHistory,
    required this.upcomingEvents,
  });

  //This function returns a map of data related to the Organisation object
  Map<String, dynamic> getData() => {
        "uid": uid,
        "orgName": orgName,
        "email": email,
        "profileURL": profileURL,
        "location": bio,
        "following": following,
        "interests": interests,
        "skills": skills,
        "volunteerHistory": volunteerHistory,
        "upcomingEvents": upcomingEvents,
      };

  //This method returns a Organisation instance based on the document snapshot given by firebase authentication
  static Organisation getUser(DocumentSnapshot snap) {
    Map<String, dynamic> map = snap.data() as Map<String, dynamic>;

    return Organisation(
      uid: map['uid'],
      orgName: map['orgName'],
      email: map['email'],
      profileURL: map['profileURL'],
      bio: map['bio'],
      following: map['following'],
      interests: map['interests'],
      skills: map['skills'],
      volunteerHistory: map['volunteerHistory'],
      upcomingEvents: map['upcomingEvents'],
    );
  }
}