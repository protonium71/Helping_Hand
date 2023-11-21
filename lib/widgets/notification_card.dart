import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:helping_hand/models/user.dart' as model;
import 'package:helping_hand/resources/auth_services.dart';

class NotificationCard extends StatelessWidget {
  int index;
  final List<dynamic> list;
  final String eventname;
  final Function(int) onDelete;
  NotificationCard({super.key, required this.index, required this.eventname, required this.list, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 113,
      // color: Colors.yellow,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
            child: Container(
              height: 85,
              // color: Colors.grey,
              child: Row(
                children: [
                  //image
                  Container( 
                    height: 85,
                    width: 85,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(100) 
                      //more than 50% of width makes circle
                    ),
                  ),
                  const SizedBox(width: 15,),
                  Container(
                    width: 260,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "📢 New Event posted : ",
                          style: TextStyle(
                            height: 1.6,
                            color: Color(0xFF1D1517),
                            fontSize: 17,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "$eventname",
                          style: const TextStyle(
                            height: 1.2,
                            color: Color.fromARGB(255, 112, 107, 109),
                            fontSize: 17,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Text(
                          "About 3 hours ago",
                          style: TextStyle(
                            color: Color.fromARGB(255, 136, 125, 128),
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 43,
                    child: IconButton(
                      onPressed: () async{
                        onDelete(index);
                      }, 
                      icon: const Icon(Icons.delete_outline_rounded, size: 25),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Divider(thickness: 0.5, color: Colors.grey[400],),
          ),
        ],
      ),
    );
  }
}