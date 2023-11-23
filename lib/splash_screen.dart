import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:helping_hand/user_type_page.dart';
import 'package:helping_hand/views/organisation/navigation_page.dart';
import 'package:helping_hand/views/user/navigation.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.wait([
      getUserData(),
      Future.delayed(
        const Duration(milliseconds: 3000),
      ),
    ]).then((snapshot) {
      String user = (snapshot.first as String);
      // ignore: avoid_print
      print(user);
      Widget next = user == "onBoard"
          ? const UserType()
          : user == "volunteer"
              ? const Navigation()
              : const NavigationPage();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => next,
        ),
      );
    });
  }

  Future<String> getUserData() async {
    if(FirebaseAuth.instance.currentUser == null) return "onBoard";
    QuerySnapshot query = await FirebaseFirestore.instance.collection('users')
                          .where('email',isEqualTo:FirebaseAuth.instance.currentUser!.email.toString()).get();
    if(query.docs.isEmpty){
      return "organiser";
    }
    else{
      return "volunteer";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LoadingAnimationWidget.flickr(leftDotColor: const Color(0xFF92A3FD), rightDotColor: Colors.black, size: 80),
      ),
    );
  }
}