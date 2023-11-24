import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helping_hand/models/user.dart' as model;
import 'package:helping_hand/providers/user_provider.dart';
import 'package:helping_hand/resources/auth_services.dart';
import 'package:helping_hand/user_type_page.dart';
import 'package:helping_hand/widgets/event_card.dart';
import 'package:provider/provider.dart';

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
  
  CollectionReference _jobs = FirebaseFirestore.instance.collection('events');
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
     model.User user = Provider.of<UserProvider>(context, listen: false).getUser;
    Map<String, dynamic> userMap = user.getData();
    List<dynamic> upcomingEvents = userMap['upcomingEvents'];
    
    return Scaffold(
      appBar: AppBar(
        actions: [
          
          IconButton(
            onPressed: () async {
              UserProvider userProvider = Provider.of(context, listen: false);
              await userProvider.refreshUser();
              model.User user = userProvider.getUser;
              Map<String, dynamic> userMap = user.getData();
              setState(() {
                _jobs = FirebaseFirestore.instance.collection('events');
              });
              
            },
            icon: const Icon(
              Icons.refresh_outlined,
              size: 25,
            ),
            splashRadius: 25,
          ),
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
          ),
          const SizedBox(
            width: 5,
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
                  var spots_rem = num.parse(documentSnapshot['totalSpots']) - num.parse(documentSnapshot['signedSpots']);
                  if(documentSnapshot['location'] == userMap['location'] && documentSnapshot['startTime'].toDate().isAfter(DateTime.now()) && !upcomingEvents.contains(documentSnapshot['eventid']) && spots_rem != 0)
                    return EventCard(documentSnapshot: documentSnapshot, user:'volunteer',);
                  else
                    return Center();
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

