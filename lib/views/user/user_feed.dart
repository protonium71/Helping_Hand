import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:helping_hand/views/user/user_feed_cards.dart';

class UserFeed extends StatefulWidget {
   const UserFeed({super.key});
  @override
  State<UserFeed> createState() => _UserFeedState();
}

class _UserFeedState extends State<UserFeed> {
  
  final CollectionReference _jobs = FirebaseFirestore.instance.collection('events');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true, 
        backgroundColor: Color(0xffCDD4E0),
        title: Text('Home Feed'),),
      body: StreamBuilder(
        stream: _jobs.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot){
          if(streamSnapshot.hasData){
            return ListView.builder( 
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index){
                final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
              return UserFeedCard(documentSnapshot: documentSnapshot);
            });
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        //title: documentSnapshot['title'].toString(), date: documentSnapshot['start_time'].toString(), location: documentSnapshot['location']
      )
    );
  }
}

