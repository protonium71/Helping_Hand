import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helping_hand/models/user.dart' as model;
import 'package:helping_hand/views/user/navigation.dart';
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
  String postedBy = "", eventname = "", profileURL = "";
  List<dynamic> notificationList = [];
  List<Map<String, dynamic>> notiDetails = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    model.User user = Provider.of<UserProvider>(context, listen: false).getUser;
    Map<String, dynamic> userMap = user.getData();
    notificationList = userMap['notifications'];
    loadDetails();
  }

  loadDetails() async {
    notiDetails.clear();
    for (String s in notificationList) {
      DocumentSnapshot snap =
          await FirebaseFirestore.instance.collection('events').doc(s).get();
      if (snap.data() != null) {
        notiDetails.add(snap.data() as Map<String, dynamic>);
      }
    }
    setState(() {
      notiDetails;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context, listen: false).getUser;
    Map<String, dynamic> userMap = user.getData();
    notificationList = userMap['notifications'];
    if (isLoading) {
      return const Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: CircularProgressIndicator(),
          ));
    }
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              final NavigationController controller = Get.find();
              controller.handleNotificationNavigation(0);
            },
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
              print(notificationList);

              isLoading = true;
              notificationList = userMap['notifications'];
              loadDetails();
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
                    return NotificationCard(
                      profileURL: notiDetails[index]['profileURL'],
                      index: index,
                      postedBy: notiDetails[index]['organiserName'],
                      eventname: notiDetails[index]['eventname'],
                      list: notificationList,
                      onDelete: (int index) async {
                        setState(() {
                          notificationList.removeAt(index);
                          notiDetails.removeAt(index);
                        });
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .update({
                          'notifications': notificationList,
                        });
                      },
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
