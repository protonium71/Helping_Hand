import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helping_hand/models/user.dart' as model;
import 'package:helping_hand/providers/user_provider.dart';
import 'package:provider/provider.dart';

class EventDetailsPage extends StatefulWidget {
  final DocumentSnapshot documentSnapshot;
  const EventDetailsPage( {super.key, required this.documentSnapshot});
  
  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  bool isFollow = false;

  // @override
  // void initState(){
  //   loadData();
  //   super.initState();
    
  // }

  loadData() async{
    // QuerySnapshot query = await FirebaseFirestore.instance.collection('users').where('following',arrayContains: widget.documentSnapshot['eventid'].toString()).get();
    // if(query.docs.isEmpty){
    //   setState(() {
    //     isFollow = false;
    //   });
    // }
    UserProvider userProvider = Provider.of(context, listen: false);
    await userProvider.refreshUser();
    model.User user = Provider.of<UserProvider>(context, listen: false).getUser;
    Map<String, dynamic> userMap = user.getData();
    for(String s in userMap['following']){
      if(s == widget.documentSnapshot['organisedBy']){
        setState(() {
          isFollow = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    loadData();
    print(isFollow);
    var spots_rem = widget.documentSnapshot['totalSpots'] - widget.documentSnapshot['signedSpots'];
    Timestamp t1 = widget.documentSnapshot['startTime'] ;
    Timestamp t2 = widget.documentSnapshot['endTime'] ;
    model.User user = Provider.of<UserProvider>(context, listen: false).getUser;
    Map<String, dynamic> userMap = user.getData();
    List<dynamic> all_events = userMap['upcomingEvents'];
    String id = userMap['uid'];
    
    DateTime s_date = t1.toDate();
    DateTime e_date = t2.toDate();
    // print(s_date.toString());
    // print(s_date.hour);
    
    String date = '${s_date.day}/${s_date.month}/${s_date.year}';
    
    return  Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.85,
              child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      
                     width: MediaQuery.of(context).size.width,
                     height: 300,
                     decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xffCDD4E0),
                    ),
                    ),
                  ),
                  
                  Text(widget.documentSnapshot['eventname'], style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                  Text(widget.documentSnapshot['organisedBy'], style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xff6379A5),)),
                  if (isFollow == false) Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Follow"),
                      IconButton(
                        onPressed: () async{
                          List<dynamic> list = userMap['following'];
                          list.add(widget.documentSnapshot['organisedBy']);
                          await FirebaseFirestore.instance.collection("users").doc(id).update({"following":list});
                          setState(() {
                            isFollow = true;
                          });
                        }, 
                        icon: Icon(Icons.add_box_outlined),
                      ),
                    ],
                  ) else SizedBox(height: 0,),
                   Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                    child: Row(
                      children: [
                        Text('$spots_rem spots remaining..', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xff878787))),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric( horizontal: 15),
                    child: Row(
                      children: [
                        Icon(Icons.date_range_rounded),
                        SizedBox(width: 10,),
                        Text('Date & time', style: TextStyle(fontSize: 20, color: Color(0xff6379A5), fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric( horizontal: 50),
                    child: Row(
                      children: [
                        Text(date.toString(), style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                        const SizedBox(width: 50,),
                        Text('${s_date.hour}:${s_date.minute}--${e_date.hour}:${e_date.minute}', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  
                  
                  const SizedBox(height: 20,),
                  const Padding(
                    padding: EdgeInsets.symmetric( horizontal: 15),
                    child: Row(
                      children: [
                        SizedBox(height: 20,),
                        Icon(Icons.location_on_outlined),
                        SizedBox(width: 10,),
                        Text('Location', style: TextStyle(fontSize: 20, color: Color(0xff6379A5), fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric( horizontal: 50),
                    child: Row(
                      children: [
                        Text(widget.documentSnapshot['location'].toString(), style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20,),
                  const Padding(
                    padding: EdgeInsets.symmetric( horizontal: 15),
                    child: Row(
                      children: [
                        SizedBox(height: 20,),
                        Icon(Icons.event_available_outlined),
                        SizedBox(width: 10,),
                        Text('Event Details..', style: TextStyle(fontSize: 20, color: Color(0xff6379A5), fontWeight: FontWeight.bold)),
                    
                      ],
                    ),
                  ),
                  const SizedBox(height: 5,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Text(widget.documentSnapshot['details']),
                  
                  )
                ],
              ),
                      ),
            ),
            const SizedBox(height: 20,),
            ElevatedButton(
            
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xffBBBBD6),),
              onPressed: () async{
                all_events.add(widget.documentSnapshot['eventid']);
                await FirebaseFirestore.instance.collection("users").doc(id).update({"upcomingEvents":all_events});
              }, 
              child: const Text('Sign up', style: TextStyle(color: Colors.black),)),
        ]
        ),
      ), 
    );
  }
}