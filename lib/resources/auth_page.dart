// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get_connect/http/src/utils/utils.dart';
// import 'package:helping_hand/views/organisation/home_page.dart';
// import 'package:helping_hand/views/organisation/login_or_register.dart';
// import 'package:helping_hand/views/user/login_or_register.dart';
// import 'package:helping_hand/views/user/navigation.dart';

// class AuthPage extends StatefulWidget {
//   final String type;
//   // BuildContext? context1;
//   const AuthPage({super.key, required this.type,});

//   @override
//   State<AuthPage> createState() => _AuthPageState();
// }

// class _AuthPageState extends State<AuthPage> {
//   String type = "";

//   @override
//   Widget build(BuildContext context) {
//     if(widget.type == "volunteer"){
//       return Scaffold(
//         body: StreamBuilder<User?>(
//           stream: FirebaseAuth.instance.authStateChanges(),
//           builder: (context, snapshot) {
//             //user is logged in
//             if(snapshot.hasData){
//               return const Navigation();
//             }
//             //user is not logged in
//             else{
//               return const LoginOrRegisterPage();
//             }
//           },
//         ),
//       );
//     }
//     else{
//       return Scaffold(
//         body: StreamBuilder<User?>(
//           stream: FirebaseAuth.instance.authStateChanges(),
//           builder: (context, snapshot) {
//             //user is logged in
//             if(snapshot.hasData){
//               return HomePage(
//                 change: (){
//                   setState(() {
//                     type = "logout";
//                   });
//                 }
//               );
//             }
//             //user is not logged in
//             else{
//               return LoginOrRegisterPageOrg(type: type);
//             }
//           },
//         ),
//       );
//     }
//   }
// }