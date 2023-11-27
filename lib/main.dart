import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:helping_hand/firebase_options.dart';
import 'package:helping_hand/providers/organisation_provider.dart';
import 'package:helping_hand/providers/user_provider.dart';
import 'package:helping_hand/resources/notifications.dart';
import 'package:helping_hand/splash_screen.dart';
import 'package:helping_hand/views/user/notification_page.dart';
import 'package:helping_hand/views/user/user_feed.dart';
import 'package:helping_hand/widgets/utils.dart';
import 'package:provider/provider.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  // ignore: avoid_print
  print("Handling a background message: ${message.messageId}");
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Notifications().getFirebaseMessagingToken();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await Notifications().initNotification();
  await Notifications().initPushNotification();
  await Notifications().createNotificationChannel('chats', 'Chats');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrganisationProvider(),
        ),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        theme: ThemeData(
          primarySwatch: colorCustom,
          fontFamily: 'Poppins'
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        routes: {
          NotificationPage.route: (context) => const NotificationPage(),
          UserFeed.route:(context) => const UserFeed(),
        },
      ),
    );
  }
}
