import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:helping_hand/firebase_options.dart';
import 'package:helping_hand/utilities/utils.dart';
import 'package:helping_hand/resources/auth_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helping_hand/views/user/search_page.dart';
//import 'package:helping_hand/views/user/user_feed.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: colorCustom,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
      ),
      debugShowCheckedModeBanner: false,
      home: const AuthPage(),
    );
  }
}
