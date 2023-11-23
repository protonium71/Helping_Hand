// This class is used as the user model class
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String? uid;
  String? username;
  String? profileURL;
  String? email;
  String? location;
  List<dynamic>? interests;
  List<dynamic>? skills;
  List<dynamic>? volunteerHistory;  // list of job ids
  List<dynamic>? upcomingEvents;  // list of job ids
  List<dynamic>? following;  // list of organisation ids
  List<dynamic>? notifications;
  int? volunteeringHours;
  String? ftoken;

  User({
    this.uid,
    this.username,
    this.email,
    this.profileURL,
    this.location,
    this.interests,
    this.skills,
    this.volunteerHistory,
    this.upcomingEvents,
    this.following,
    this.notifications,
    this.volunteeringHours,
    this.ftoken,
  });

  //This function returns a map of data related to the user object
  Map<String, dynamic> getData() => {
        "uid": uid,
        "username": username,
        "email": email,
        "profileURL": profileURL,
        "location": location,
        "interests": interests,
        "skills": skills,
        "volunteerHistory": volunteerHistory,
        "upcomingEvents": upcomingEvents,
        "following": following,
        "notifications": notifications,
        "volunteeringHours": volunteeringHours,
        "ftoken": ftoken,
      };

  //This method returns a user instance based on the document snapshot given by firebase authentication
  static User getUser(DocumentSnapshot snap) {
    Map<String, dynamic> map = snap.data() as Map<String, dynamic>;

    return User(
      uid: map['uid'],
      username: map['username'],
      email: map['email'],
      profileURL: map['profileURL'],
      location: map['location'],
      interests: map['interests'],
      skills: map['skills'],
      volunteerHistory: map['volunteerHistory'],
      upcomingEvents: map['upcomingEvents'],
      following: map['following'],
      notifications: map['notifications'],
      volunteeringHours: map['volunteeringHours'],
      ftoken: map['ftoken'],
    );
  }
  
}