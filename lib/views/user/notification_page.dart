import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:helping_hand/models/user.dart' as model;
import 'package:helping_hand/resources/notifications.dart';
import 'package:helping_hand/widgets/my_button.dart';
import 'package:helping_hand/widgets/notification_card.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});
  static const route = '/notification-page';

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  String postedBy = "", eventname = "";
  List<dynamic> notificationList = [];

  loadData(dynamic id) async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('events')
        .doc(id.toString())
        .get();
    print(id);
    if (snap.data() != null) {
      Map<String, dynamic> map = snap.data() as Map<String, dynamic>;
      setState(() {
        postedBy = map['organiserName'];
        eventname = map['eventname'];
        print(eventname);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context, listen: false).getUser;
    Map<String, dynamic> userMap = user.getData();
    notificationList = userMap['notifications'];
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {},
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 20,
            )),
        actions: [
          IconButton(
            onPressed: () async {
              UserProvider userProvider = Provider.of(context, listen: false);
              await userProvider.refreshUser();
              model.User user = userProvider.getUser;
              Map<String, dynamic> userMap = user.getData();
              setState(() {
                notificationList = userMap['notifications'];
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
          'Notification',
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
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: notificationList.length,
                  itemBuilder: (context, index) {
                    loadData(notificationList[index]);
                    return NotificationCard(
                      index: index, 
                      eventname: eventname, 
                      list: notificationList,
                      onDelete: (int index) async{
                        setState(() {
                          notificationList.removeAt(index);
                        });
                        await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update({
                          'notifications' : notificationList,
                        });
                      },
                    );
                  }
                ),
            ),
          ],
        ),
      ),
    );
  }
}
