import 'package:flutter/material.dart';

class FollowingCard extends StatelessWidget {
 final String text;
  final double size;

  const FollowingCard({super.key, required this.text, required this.size});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Container(
      // color: Colors.teal[400],
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8), 
        // color: Colors.teal[400],
        border: Border.all(color: const Color(0xffBBBBD6))
        
      ),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container( 
            height: height*0.07,
            width: height*0.07,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(100) 
              //more than 50% of width makes circle
            ),
          ),
          SizedBox(height: height*0.01,),
          Container(
            height: height*0.045,
            // color: Colors.red,
            child: Text(
              text, 
              maxLines: 3,
              style: TextStyle(
                fontSize: size, 
                fontWeight: FontWeight.bold
              ), 
              textAlign: TextAlign.center,
            )
          ),
        ],
      )
    );
  }
}