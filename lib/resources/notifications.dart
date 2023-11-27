import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:helping_hand/main.dart';
import 'package:helping_hand/models/organisation.dart';
import 'package:helping_hand/models/user.dart' as model;
import 'package:helping_hand/resources/auth_services.dart';
import 'package:helping_hand/views/user/navigation.dart';
import 'package:http/http.dart';

class Notifications {
  // for accessing firebase messaging (Push Notification)
  final FirebaseMessaging fMessaging = FirebaseMessaging.instance;

  //
  static String? ftoken;

  //
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // for getting firebase messaging token
  Future<void> getFirebaseMessagingToken() async {
    await fMessaging.requestPermission();
    await fMessaging.getToken().then((value) {
      ftoken = value;
      // ignore: avoid_print
      print('\nftoken: $value');
    });
  }

  //update ftoken
  Future<void> updateToken() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'ftoken': ftoken,
    });
  }

  // for sending push notification
  static Future<void> sendPushNotification(
      String msg, String ftoken, String user, String eventid) async {
    try {
      final body = {
        "to": ftoken,
        "notification": {
          "title": "📢 New Event posted by $user", //our name should be send
          "body": msg,
          "android_channel_id": "chats",
        },
        "data": {
          "eventid": eventid,
        },
      };

      await post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader:
                'key=AAAA43CJnQU:APA91bHo2IgrWpsyy0mzcorQrPemkKn1wCj_birWdMvuEy82SztnHQMwBci28XDH2hw4w83jrwlxj0jrgFZven7cA4E0Kzc-Hy-zxTx5bh7du09CDpNLiWXxKRO4DLWoFsiQtW1CQOpV'
          },
          body: jsonEncode(body));
    } catch (e) {
      // ignore: avoid_print
      // print('\nsendPushNotificationE: $e');
    }
  }

  //first create list of ftokens of followers of the organisation
  static Future<void> createUserList(
      String msg, String user, String eventid) async {
    Organisation org = await AuthService().getOrganisationDetails();
    List<String> userTokens = [];
    List<dynamic>? followers = org.following;
    if (followers != null) {
      for (String user in followers) {
        final data = await FirebaseFirestore.instance
            .collection('users')
            .where('uid', isEqualTo: user)
            .get();
        userTokens.add(data.docs.first.data()['ftoken']);
      }
      for (String fToken in userTokens) {
        if(fToken != ftoken) {
          print(fToken);
          sendPushNotification(msg, fToken, user, eventid);
        }
      }
    }
  }

  //create notification channel
  Future<void> createNotificationChannel(String id, String name) async {
    var androidNotificationChannel = AndroidNotificationChannel(
      id,
      name,
      importance: Importance.max,
    );
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidNotificationChannel);
  }

  //store notification in firebase
  static Future<void> storeNotification(Map<String, dynamic> data) async {
    model.User user = await AuthService().getUserDetails();
    List<dynamic> list = user.notifications!;
    print("list : $list");
    list.add(data['eventid']);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'notifications': list,
    });
  }

  //notification listening initialisation
  Future<void> initNotification() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (notificationResponse) {
      final message = RemoteMessage.fromMap(
          jsonDecode(notificationResponse.payload as String));
      // print(message.data);
      handleMessage(message);
    });
  }

  //handle notification
  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
    // print(navigatorKey.currentState);
    storeNotification(message.data);
    // navigatorKey.currentState?.pushNamed(NotificationPage.route, arguments: message);
    // Get.toNamed('/');
    final NavigationController controller = Get.find();
    controller.handleNotificationNavigation(3);
  }

  //init push notification
  Future<void> initPushNotification() async {
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification!.android;

      // ignore: avoid_print
      // print(message.data);
      // If `onMessage` is triggered with a notification, construct our own
      // local notification to show to users using the created channel.
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          0,
          notification.title,
          notification.body,
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'chats',
              'Chats',
              importance: Importance.max,
              priority: Priority.max,
              largeIcon: DrawableResourceAndroidBitmap("logo"),
            ),
            // other properties...
          ),
          payload: jsonEncode(message.toMap()),
        );
      }
    });
  }
}
