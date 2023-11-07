// This class is used as the user model class
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String? uid;
  String? userName;
  String? profileURL;
  String? email;
  String? location;
  List<String> interests = [];
  List<String> skills = [];
  List<String> volunteerHistory = [];  // list of job ids
  List<String> upcomingEvents = [];  // list of job ids
  List<String> following = [];  // list of organisation ids
  String? volunteeringHours;

  User({
    this.uid,
    this.userName,
    this.email,
    this.profileURL,
    this.location,
    required this.interests,
    required this.skills,
    required this.volunteerHistory,
    required this.upcomingEvents,
    required this.following,
    this.volunteeringHours,
  });

  //This function returns a map of data related to the user object
  Map<String, dynamic> getData() => {
        "uid": uid,
        "userName": userName,
        "email": email,
        "profileURL": profileURL,
        "location": location,
        "interests": interests,
        "skills": skills,
        "volunteerHistory": volunteerHistory,
        "upcomingEvents": upcomingEvents,
        "following": following,
        "volunteeringHours": volunteeringHours,
      };

  //This method returns a user instance based on the document snapshot given by firebase authentication
  static User getUser(DocumentSnapshot snap) {
    Map<String, dynamic> map = snap.data() as Map<String, dynamic>;

    return User(
      uid: map['uid'],
      userName: map['userName'],
      email: map['email'],
      profileURL: map['profileURL'],
      location: map['location'],
      interests: map['interests'],
      skills: map['skills'],
      volunteerHistory: map['volunteerHistory'],
      upcomingEvents: map['upcomingEvents'],
      following: map['following'],
      volunteeringHours: map['volunteeringHours'],
    );
  }
}