import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FollowingCard extends StatefulWidget {
  final String text;
  final double size;

  const FollowingCard({super.key, required this.text, required this.size});

  @override
  State<FollowingCard> createState() => _FollowingCardState();
}

class _FollowingCardState extends State<FollowingCard> {
  String orgname = "";
  String profileURL = "";

  @override
  void initState() {
    super.initState();
    random();
  }

  random() async {
    final data = await FirebaseFirestore.instance
        .collection('organisations')
        .where('uid', isEqualTo: widget.text)
        .get();
    setState(() {
      orgname = data.docs.first.data()['orgname'];
      profileURL = data.docs.first.data()['profileURL'];
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
        // color: Colors.teal[400],
        padding: EdgeInsets.symmetric(
            vertical: height * 0.01, horizontal: height * 0.01),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            // color: Colors.teal[400],
            border: Border.all(color: const Color(0xffBBBBD6))),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: height * 0.07,
              width: height * 0.07,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(100),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: profileURL != ""
                      ? NetworkImage(profileURL)
                      : const AssetImage(
                              "lib/assets/images/default_profile.jpg")
                          as ImageProvider,
                ),
                //more than 50% of width makes circle
              ),
              //child: ,
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Container(
                height: height * 0.045,
                // color: Colors.red,
                child: Text(
                  orgname,
                  maxLines: 3,
                  style: TextStyle(
                      fontSize: widget.size, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                )),
          ],
        ));
  }
}
