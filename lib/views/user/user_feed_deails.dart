

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserFeedDetail extends StatefulWidget {
  final DocumentSnapshot documentSnapshot;
  const UserFeedDetail( {super.key, required this.documentSnapshot});
  
  @override
  State<UserFeedDetail> createState() => _UserFeedDetailState();
}

class _UserFeedDetailState extends State<UserFeedDetail> {
  

  @override
  Widget build(BuildContext context) {
    var spots_rem = widget.documentSnapshot['total_spots'] - widget.documentSnapshot['filled_spots'];
    Timestamp t1 = widget.documentSnapshot['start_time'] ;
    Timestamp t2 = widget.documentSnapshot['end_time'] ;
    
    DateTime s_date = t1.toDate();
    DateTime e_date = t2.toDate();
    print(s_date.toString());
    print(s_date.hour);
    
    String date = s_date.day.toString() + '/' + s_date.month.toString() + '/' + s_date.year.toString();
    
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
                  
                  Text(widget.documentSnapshot['title'], style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                  Text(widget.documentSnapshot['organisation'], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xff6379A5))),
                   Padding(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                    child: Row(
                      children: [
                        Text(spots_rem.toString()  + ' spots remaining..', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xff878787))),
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
                    padding: EdgeInsets.symmetric( horizontal: 50),
                    child: Row(
                      children: [
                        Text(date.toString(), style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                        SizedBox(width: 50,),
                        Text(s_date.hour.toString()+':'+s_date.minute.toString()+'--'+e_date.hour.toString()+':'+e_date.minute.toString(), style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
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
                    padding: EdgeInsets.symmetric( horizontal: 50),
                    child: Row(
                      children: [
                        Text(widget.documentSnapshot['location'].toString(), style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
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
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    child: Text(widget.documentSnapshot['details']),
                  
                  )
                ],
              ),
                      ),
            ),
            SizedBox(height: 20,),
            ElevatedButton(
            
              style: ElevatedButton.styleFrom(backgroundColor: Color(0xffBBBBD6),),
              onPressed: (){}, 
              child: Text('Sign up', style: TextStyle(color: Colors.black),)),
        ]
        ),
      ),
      
      
    );
  }
}