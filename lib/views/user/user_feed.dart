import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helping_hand/resources/auth_services.dart';
import 'package:helping_hand/user_type_page.dart';
import 'package:helping_hand/widgets/event_card.dart';

class UserFeed extends StatefulWidget {
   const UserFeed({super.key});
   static const route = '/user-feed-page';
  @override
  State<UserFeed> createState() => _UserFeedState();
}

class _UserFeedState extends State<UserFeed> {

  @override
  void initState() {
    super.initState();
  }
  
  final CollectionReference _jobs = FirebaseFirestore.instance.collection('events');
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async{
              await AuthService().logoutUser();
              // ignore: use_build_context_synchronously
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const UserType(),
                ),
              );
            }, 
            icon: const Icon(Icons.logout)
          )
        ],
        centerTitle: true, 
        backgroundColor: const Color(0xffCDD4E0),
        title: const Text('Home Feed'),),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width*0.04),
        child: StreamBuilder(
          stream: _jobs.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot){
            if(streamSnapshot.hasData){
              return ListView.builder( 
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index){
                  final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                return EventCard(documentSnapshot: documentSnapshot);
              });
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        ),
      )
    );
  }
}

