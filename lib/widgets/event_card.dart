import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helping_hand/views/user/event_details_page.dart';

class EventCard extends StatelessWidget {
  final DocumentSnapshot documentSnapshot;
  const EventCard({super.key, required this.documentSnapshot});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Timestamp t = documentSnapshot['startTime'] as Timestamp;
    DateTime startDate = t.toDate();
    String date = '${startDate.day}/${startDate.month}/${startDate.year}';

    return Padding(
      padding: EdgeInsets.symmetric(vertical: height*0.01),
      child: SizedBox(
        height: height*0.22,
        child: Row(
          children: [
            Container(
              height: height*0.22,
              width: width*0.42,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.red,
              ),
            ),
            Container(
              height: height*0.22,
              width: width*0.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width*0.02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: height*0.18,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: height*0.005,),
                          Text(
                            documentSnapshot['eventname'],
                              style: const TextStyle(
                                  color: Color(0xFF1D1517),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                              ),
                          ),
                          SizedBox(height: height*0.005,),
                          Row(
                            children: [
                              const Icon(Icons.location_on_outlined, color: Color(0xFF7B6F72),),
                              SizedBox(width: width*0.015,),
                              Text(documentSnapshot['location'], style: const TextStyle(fontSize: 15, color: Color(0xFF7B6F72))),
                            ],
                          ),
                          SizedBox(height: height*0.01,),
                          Row(
                            children: [
                              const Icon(Icons.date_range_outlined, color: Color(0xFF7B6F72),),
                              SizedBox(width: width*0.015,),
                              Text(date, style: const TextStyle(fontSize: 15, color: Color(0xFF7B6F72))),
                            ],
                          ),
                          SizedBox(height: height*0.01,),
                          Row(
                            children: [
                              const Icon(Icons.people_alt_outlined, color: Color(0xFF7B6F72),),
                              SizedBox(width: width*0.015,),
                              Text(documentSnapshot['signedSpots'].toString(), style: const TextStyle(fontSize: 15, color: Color(0xFF7B6F72))),
                            ],
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: (){},
                      child: Container(
                        height: height*0.04,
                        width: width*0.25,
                        decoration: BoxDecoration(
                          color: const Color(0xff6379A5), 
                          borderRadius: BorderRadius.circular(5),
                          gradient: const LinearGradient(
                            begin: Alignment(-1.00, 0.08),
                            end: Alignment(1, -0.08),
                            colors: [Color(0xFF92A3FD), Color(0xFF9DCEFF)],
                          ),
                        ),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            EventDetailsPage(documentSnapshot: documentSnapshot)));
                          },
                          child: const Center(
                            child: Text('Details', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}             