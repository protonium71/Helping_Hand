//import 'package:Helping_Hand/lib/views/user/user_feed_deails.dart';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helping_hand/views/user/user_feed_deails.dart';

class UserFeedCard extends StatelessWidget {
  final DocumentSnapshot documentSnapshot;
  const UserFeedCard({super.key, required this.documentSnapshot});


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    String title = documentSnapshot['title'];
    Timestamp t = documentSnapshot['start_time'] as Timestamp;
    DateTime start_date = t.toDate();
    String date = start_date.day.toString() + '/' + start_date.month.toString() + '/' + start_date.year.toString();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:7.5, horizontal: 15),
      child: Container(
        height: height / 4,
        
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color(0xffCDD4E0),
        ),
        child: Row(
          children: [
            Container(
              height: height / 4,
              width: (width - 30)/ 2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blueGrey,
              ),
            ),
            Column(
              children: [
                Container(
                  //color: Colors.redAccent,
                  height: 3* (height / 16),
                  width:  (width - 30)/ 2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xffCDD4E0),
                  ),
                  child:   Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(documentSnapshot['title'], style: const TextStyle(fontSize:15, fontWeight: FontWeight.bold)),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical:6),
                          child: Row(
                            children: [
                              const Icon(Icons.date_range_rounded),
                              const SizedBox(width: 5,),
                              
                              
                              Text(date,  style: const TextStyle(fontSize:13, ),),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical:6),
                          child: Row(
                            children: [
                              const Icon(Icons.location_on_outlined),
                              const SizedBox(width: 5,),
                              Text(documentSnapshot['location'],  style: const TextStyle(fontSize:13),),
                            ],
                          ),
                        ),
                        
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xffBBBBD6)),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => UserFeedDetail(documentSnapshot: documentSnapshot)));
                  }, 
                  child: const Text('details..', style: TextStyle(color: Colors.black87),)
                )
      
              ],
            ),
          ],
        ),
      ),
    );
  }

  void onPressed() {
  }
}
              