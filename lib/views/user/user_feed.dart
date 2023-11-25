import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helping_hand/models/user.dart' as model;
import 'package:helping_hand/providers/user_provider.dart';
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
        // appBar: AppBar(
        //   leading: GestureDetector(
        //     onTap: (){},
        //     child: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20,)
        //   ),
        //   centerTitle: true,
        //   title:  const Text(
        //     'Profile',
        //     style: TextStyle(
        //         color: Color(0xFF1D1517),
        //         fontSize: 25,
        //         fontFamily: 'Poppins',
        //         fontWeight: FontWeight.w700,
        //     ),
        //   ),
        //   titleTextStyle: const TextStyle(color: Colors.black87, fontSize: 28),
        //   backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        //   elevation: 0,
        // ),
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              child: Image.asset('lib/assets/images/logo.png'),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () async {
                UserProvider userProvider = Provider.of(context, listen: false);
                await userProvider.refreshUser();
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
            const SizedBox(
              width: 5,
            )
          ],
          centerTitle: true,
          title: const Text(
            'Home Feed',
            style: TextStyle(
              color: Color(0xFF1D1517),
              fontSize: 25,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
            ),
          ),
          titleTextStyle: const TextStyle(color: Colors.black87, fontSize: 28),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0.5,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.04),
          child: StreamBuilder(
              stream: _jobs.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.hasData) {
                  return ListView.builder(
                      itemCount: streamSnapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot documentSnapshot =
                            streamSnapshot.data!.docs[index];
                        var spotsRem =
                            num.parse(documentSnapshot['totalSpots']) -
                                num.parse(documentSnapshot['signedSpots']);
                        if (documentSnapshot['location'] ==
                                userMap['location'] &&
                            documentSnapshot['startTime']
                                .toDate()
                                .isAfter(DateTime.now()) &&
                            !upcomingEvents
                                .contains(documentSnapshot['eventid']) &&
                            spotsRem != 0) {
                          return EventCard(
                            documentSnapshot: documentSnapshot,
                            user: 'volunteer',
                          );
                        } else {
                          return const Center();
                        }
                      });
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }),
        ));
  }
}
