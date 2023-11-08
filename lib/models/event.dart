// This class is used as the Event model class
import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  String uid;
  String eventid;
  String eventname;
  String profileURL;
  String organisedBy;
  String location;
  Timestamp startTime;
  Timestamp endTime;
  String details;
  String totalSpots;
  String signedSpots;
  String cause;

  Event({
    required this.uid,
    required this.eventid,
    required this.eventname,
    required this.profileURL,
    required this.location,
    required this.organisedBy,
    required this.startTime,
    required this.endTime,
    required this.details,
    required this.totalSpots,
    required this.signedSpots,
    required this.cause,
  });

  //This function returns a map of data related to the Event object
  Map<String, dynamic> getData() => {
        "uid": uid,
        "eventid": eventid,
        "eventname": eventname,
        "profileURL": profileURL,
        "location": location,
        "organisedBy": organisedBy,
        "startTime": startTime,
        "endTime": endTime,
        "details": details,
        "totalSpots": totalSpots,
        "signedSpots": signedSpots,
        "cause": cause,
      };

  //This method returns a Event instance based on the document snapshot given by firebase authentication
  static Event getUser(DocumentSnapshot snap) {
    Map<String, dynamic> map = snap.data() as Map<String, dynamic>;

    return Event(
      uid: map['uid'],
      eventid: map['eventid'],
      eventname: map['eventname'],
      profileURL: map['profileURL'],
      location: map['location'],
      organisedBy: map['organisedBy'],
      startTime: map['startTime'],
      endTime: map['endTime'],
      details: map['details'],
      totalSpots: map['totalSpots'],
      signedSpots: map['signedSpots'],
      cause: map['cause'],
    );
  }
}