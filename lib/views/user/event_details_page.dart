import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helping_hand/models/user.dart' as model;
import 'package:helping_hand/providers/user_provider.dart';
import 'package:provider/provider.dart';

class EventDetailsPage extends StatefulWidget {
  final DocumentSnapshot documentSnapshot;
  final String user;
  const EventDetailsPage(
      {super.key, required this.documentSnapshot, required this.user});

  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  bool isFollow = false;
  bool _isClicked = false;
  // ignore: non_constant_identifier_names
  String spots_rem = "0";

  @override
  void initState() {
    loadData();
    super.initState();
  }

  loadData() async {
    UserProvider userProvider = Provider.of(context, listen: false);
    await userProvider.refreshUser();
    // ignore: use_build_context_synchronously
    model.User user = Provider.of<UserProvider>(context, listen: false).getUser;
    Map<String, dynamic> userMap = user.getData();
    for (String s in userMap['following']) {
      if (s == widget.documentSnapshot['organiserID']) {
        setState(() {
          isFollow = true;
        });
      }
    }
  }

  void showErrorMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(message),
          );
        });
  }

  void call(int total, int signed1) {
    setState(() {
      spots_rem = (total - signed1).toString();
      _isClicked = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    String imageURL = widget.documentSnapshot['profileURL'];

    Timestamp t1 = widget.documentSnapshot['startTime'];
    Timestamp t2 = widget.documentSnapshot['endTime'];
    model.User user = Provider.of<UserProvider>(context, listen: false).getUser;
    Map<String, dynamic> userMap = user.getData();
    List<dynamic> list = userMap['following'];

    if (list.contains(widget.documentSnapshot['organiserID'])) {
      isFollow = true;
    }
    List<dynamic> allEvents = userMap['upcomingEvents'];
    if (allEvents.contains(widget.documentSnapshot['eventid'])) {
      _isClicked = true;
    }
    String id = userMap['uid'];

    DateTime sDate = t1.toDate();
    DateTime eDate = t2.toDate();
    int total = num.parse(widget.documentSnapshot['totalSpots']) as int;
    spots_rem =
        (total - num.parse(widget.documentSnapshot['signedSpots']) as int)
            .toString();

    String date = '${sDate.day}/${sDate.month}/${sDate.year}';

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 20,
            )),
        centerTitle: true,
        title: const Text(
          'Event Details',
          style: TextStyle(
            color: Color(0xFF1D1517),
            fontSize: 25,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
          ),
        ),
        titleTextStyle: const TextStyle(color: Colors.black87, fontSize: 28),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xffCDD4E0),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: imageURL != ""
                            ? NetworkImage(imageURL)
                            : const AssetImage(
                                    "lib/assets/images/default_profile.jpg")
                                as ImageProvider,
                      ),
                    ),
                  ),
                ),
                Text(
                  widget.documentSnapshot['eventname'],
                  style: const TextStyle(
                      fontSize: 27, fontWeight: FontWeight.w400),
                ),
                Text("by ${widget.documentSnapshot['organiserName']}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff6379A5),
                    )),
                if (isFollow == false)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Follow",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400)),
                      IconButton(
                        onPressed: () async {
                          List<dynamic> list = userMap['following'];
                          list.add(widget.documentSnapshot['organiserID']);
                          await FirebaseFirestore.instance
                              .collection("users")
                              .doc(id)
                              .update({"following": list});
                          setState(() {
                            isFollow = true;
                            // spots_rem = "3";
                          });
                        },
                        icon: const Icon(Icons.add_box_outlined),
                      ),
                    ],
                  )
                else
                  const SizedBox(
                    height: 0,
                  ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  child: Row(
                    children: [
                      const Text('Spots Remaining     ',
                          style: TextStyle(
                            fontSize: 20,
                          )),
                      Text(spots_rem,
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff878787))),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      Icon(Icons.date_range_rounded),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Date & time',
                          style: TextStyle(
                              fontSize: 20, color: Color(0xff6379A5))),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(date.toString(),
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w400))),
                      const SizedBox(
                        width: 50,
                      ),
                      Text(
                          '${sDate.hour}:${sDate.minute}--${eDate.hour}:${eDate.minute}',
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w400)),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Icon(Icons.location_on_outlined),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Location',
                          style: TextStyle(
                              fontSize: 20,
                              color: Color(0xff6379A5),
                              fontWeight: FontWeight.w400)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Row(
                    children: [
                      Text(widget.documentSnapshot['location'].toString(),
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w400)),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Icon(Icons.event_available_outlined),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Event Details',
                          style: TextStyle(
                              fontSize: 20,
                              color: Color(0xff6379A5),
                              fontWeight: FontWeight.w400)),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Row(
                    children: [
                      Container(
                          child: Text(widget.documentSnapshot['details'],
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w400))),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            widget.user == "volunteer"
                ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffBBBBD6),
                    ),
                    onPressed: _isClicked
                        ? null
                        : () async {
                            model.User user = Provider.of<UserProvider>(context,
                                    listen: false)
                                .getUser;
                            Map<String, dynamic> userMap = user.getData();

                            List<dynamic> allEvents = userMap['upcomingEvents'];
                            String id = userMap['uid'];
                            String eventID = widget.documentSnapshot['eventid'];
                            String signed =
                                widget.documentSnapshot['signedSpots'];
                            int signed1 = num.parse(signed) as int;
                            signed1++;

                            allEvents.add(widget.documentSnapshot['eventid']);
                            await FirebaseFirestore.instance
                                .collection("users")
                                .doc(id)
                                .update({"upcomingEvents": allEvents});
                            await FirebaseFirestore.instance
                                .collection("events")
                                .doc(eventID)
                                .update({"signedSpots": signed1.toString()});

                            call(total, signed1);
                            showErrorMessage('you signed up for this event..');
                          },
                    child: const Text(
                      'Sign up',
                      style: TextStyle(color: Colors.black),
                    ))
                : const Center(),
          ]),
        ),
      ),
    );
  }
}
