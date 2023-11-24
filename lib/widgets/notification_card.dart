import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NotificationCard extends StatelessWidget {
  int index;
  final List<dynamic> list;
  final String eventname;
  final String postedBy;
  final Function(int) onDelete;
  NotificationCard({super.key, required this.index, required this.eventname, required this.list, required this.onDelete, required this.postedBy});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: 113,
      // color: Colors.yellow,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: height*0.005, horizontal: width*0.025),
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
                  SizedBox(width: width*0.02,),
                  Container(
                    width: width*0.6,
                    // color: Colors.red,
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
                          eventname,
                          style: const TextStyle(
                            height: 1.2,
                            color: Color.fromARGB(255, 112, 107, 109),
                            fontSize: 17,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "by $postedBy",
                          style: const TextStyle(
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
                    height: width*0.2,
                    width: width*0.12,
                    // color: Colors.white,
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
            padding: EdgeInsets.symmetric(horizontal: width*0.04),
            child: Divider(thickness: 0.5, color: Colors.grey[400],),
          ),
        ],
      ),
    );
  }
}