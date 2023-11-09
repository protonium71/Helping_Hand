import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:helping_hand/views/user/login_or_register.dart';
import 'package:helping_hand/views/user/navigation.dart';
import 'package:helping_hand/views/user/temp.dart';
import 'package:helping_hand/views/user/user_feed.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // print('yash' + snapshot.hasData.toString());
          //user is logged in
          if(snapshot.hasData){
            
            return const Navigation();
          }
          //user is not logged in
          else{
            return const LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}