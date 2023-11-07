// This class is used as the Job model class
import 'package:cloud_firestore/cloud_firestore.dart';

class Job {
  String uid;
  String jid;
  String jobName;
  String profileURL;
  String organisedBy;
  String location;
  Timestamp startTime;
  Timestamp endTime;
  String details;
  String totalSpots;
  String signedSpots;
  String cause;

  Job({
    required this.uid,
    required this.jid,
    required this.jobName,
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

  //This function returns a map of data related to the Job object
  Map<String, dynamic> getData() => {
        "uid": uid,
        "jid": jid,
        "jobName": jobName,
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

  //This method returns a Job instance based on the document snapshot given by firebase authentication
  static Job getUser(DocumentSnapshot snap) {
    Map<String, dynamic> map = snap.data() as Map<String, dynamic>;

    return Job(
      uid: map['uid'],
      jid: map['jid'],
      jobName: map['jobName'],
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