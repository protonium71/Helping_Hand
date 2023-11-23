import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:helping_hand/models/user.dart' as model;
import 'package:helping_hand/resources/auth_services.dart';
import 'package:http/http.dart';

class Notifications{
  // for accessing firebase messaging (Push Notification)
  static FirebaseMessaging fMessaging = FirebaseMessaging.instance;

  // for getting firebase messaging token
  static Future<void> getFirebaseMessagingToken() async {
    await fMessaging.requestPermission();
    String? ftoken;
    await fMessaging.getToken().then((value) {
      ftoken = value;
      // ignore: avoid_print
      print('\nftoken: $value');
    });
    await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update({
      'ftoken' : ftoken,
    });
  }

  // for sending push notification
  static Future<void> sendPushNotification(String msg, String ftoken, String user) async {
    try {
      final body = {
        "to": ftoken,
        "notification": {
          "title": "New Event posted by : $user", //our name should be send
          "body": msg,
          "android_channel_id": "chats",
        },
        "data": {
          "eventid": FirebaseAuth.instance.currentUser!.uid,
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
      print('\nsendPushNotificationE: $e');
    }
  }

  //first create list of followers of the organisation
  static Future<void> createUserList(String msg, String user) async{
    model.User org = await AuthService().getUserDetails();
    List<String> userTokens = [];
    List<dynamic>? followers = org.following;
    if(followers != null){
      for(String user in followers){
        final data = await FirebaseFirestore.instance
          .collection('users')
          .where('uid', isEqualTo: user)
          .get();
        userTokens.add(data.docs.first.data()['ftoken']);
      }
      for(String ftoken in userTokens){
        sendPushNotification(msg, ftoken, user);
      }
    }
  }

  //create notification channel
  static Future<void> createNotificationChannel(String id, String name) async {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
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
  static Future<void> storeNotification(Map<String, dynamic> data) async{
    model.User user = await AuthService().getUserDetails();
    List<dynamic> list = user.notifications!;
    list.add(data['eventid']);
    await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update({
      'notifications' : list,
    });
  }

  //notification listening initialisation
  static Future<void> initNotification() async{
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =  AndroidInitializationSettings('ic_launcher');
    const InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid,);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async{
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification!.android;
      storeNotification(message.data);
      // ignore: avoid_print
      print(message.data);
      await flutterLocalNotificationsPlugin.initialize(initializationSettings);
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
                // largeIcon: FilePathAndroidBitmap(_bitmap),
              ),
                // other properties...
              ),
            );
      }
    });
  }

}