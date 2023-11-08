import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:helping_hand/views/user/login_or_register.dart';
import 'package:helping_hand/views/user/user_feed.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //user is logged in
          if(snapshot.hasData){
            return const UserFeed();
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