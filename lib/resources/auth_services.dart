import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:helping_hand/models/organisation.dart';
import 'package:helping_hand/models/user.dart' as model;
import 'package:uuid/uuid.dart';

class AuthService {
  //Instance of firebase authentication
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Instance of google authentication
  static final GoogleSignIn _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? gUser;
  GoogleSignInAuthentication? gAuth;

  //google sign in
  signInWithGoogle({required BuildContext context}) async{
    try{
      //show loading circle
      showDialog(context: context, builder: (context){
        return const Center(
          child: CircularProgressIndicator(),
        );
      });

      //begin interactive sign in process
      gUser = await _googleSignIn.signIn();

      //obtain auth details from request
      gAuth = await gUser!.authentication;

      print(gUser!.id);

      //create a new credential for user
      final cred = GoogleAuthProvider.credential(
        accessToken: gAuth!.accessToken,
        idToken: gAuth!.idToken,
      );

      //if the user is not present in the firestore database add it
      QuerySnapshot query = await FirebaseFirestore.instance.collection('users').where('email',isEqualTo:gUser!.email.toString()).get();
      
      if (query.docs.isEmpty){
        await FirebaseAuth.instance.signInWithCredential(cred).then((value) {
          Navigator.pop(context);
        });

        model.User user = model.User(
          username: '',
          email: gUser!.email,
          location: '',
          profileURL: '',
          volunteeringHours: 0,
          uid: _auth.currentUser!.uid.toString(), 
          interests: [], 
          skills: [], 
          volunteerHistory: [], 
          upcomingEvents: [], 
          following: [],
          ftoken: '',
        );

        await _firestore
            .collection('users')
            .doc(_auth.currentUser!.uid.toString())
            .set(user.getData());
      }

      //finally, lets sign in
      else{
        await FirebaseAuth.instance.signInWithCredential(cred).then((value) {
          Navigator.pop(context);
        });
      }
      
    } on FirebaseAuthException catch(e){
      print(e.code);
    }
  }

  //google sign out
  signOutWithGoogle() async{
    // print(gUser!.email);
    // Sign out with google
    await _googleSignIn.signOut();
  }

  //method to get user details
  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snapshot = await _firestore.collection('users').doc(currentUser.uid).get();

    // print(currentUser.uid);

    return model.User.getUser(snapshot);
  }

  //method to get organisation details
  Future<Organisation> getOrganisationDetails() async {
    User currentOrg = _auth.currentUser!;

    DocumentSnapshot snapshot = await _firestore.collection('organisations').doc(currentOrg.uid).get();

    return Organisation.getOrganisation(snapshot);
  }

  //method to sign up a new user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String location,
    required BuildContext context,
  }) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          username.isNotEmpty &&
          location.isNotEmpty) {
        await _auth.createUserWithEmailAndPassword(
            email: email, password: password).then((value) async {
              

              model.User user = model.User(
                username: username,
                email: email,
                uid: _auth.currentUser!.uid, 
                location: location,
                profileURL: '',
                volunteeringHours: 0,
                interests: [], 
                skills: [], 
                volunteerHistory: [], 
                upcomingEvents: [], 
                following: [],
                ftoken: '',
              );
              Navigator.pop(context);
              await _firestore
                  .collection('users')
                  .doc(_auth.currentUser!.uid)
                  .set(user.getData());
              
            });

        

        
        // await _firestore
        //     .collection('type')
        //     .doc(cred.user!.uid)
        //     .set({'type':"user"});
      }
      res = "Sign Up Success";
    } on FirebaseAuthException catch(err) {
      res = err.code.toString();
    }
    return res;
  }

  // Future<String> signUpOrganisation({
  //   required String email,
  //   required String password,
  //   required String username,
  //   required String category,
  //   required String level,
  // }) async {
  //   String res = "Some error occured";
  //   try {
  //     DocumentReference ref =
  //         _firestore.collection('allowedAdmins').doc('allowedAdminsList');
  //     DocumentSnapshot snap = await ref.get();

  //     Map<String, dynamic> map = snap.data() as Map<String, dynamic>;
  //     var authorisedAdmins = map['list'];

  //     //This flag is used to check weather the admin is present in authorised admins or not
  //     bool isPresent = false;
  //     for (String s in authorisedAdmins) {
  //       if (s == email) isPresent = true;
  //     }
  //     if (isPresent) {
  //       if (email.isNotEmpty ||
  //           password.isNotEmpty ||
  //           username.isNotEmpty ||
  //           category.isNotEmpty ||
  //           level.isNotEmpty) {
  //         UserCredential cred = await _auth.createUserWithEmailAndPassword(
  //             email: email, password: password);

  //         Admin admin = Admin(
  //             username: username,
  //             category: category,
  //             email: email,
  //             uid: cred.user!.uid,
  //             level: level);

  //         await _firestore
  //             .collection('admin')
  //             .doc(cred.user!.uid)
  //             .set(admin.getData());

  //         await _firestore
  //             .collection('type')
  //             .doc(cred.user!.uid)
  //             .set({'type':"admin"});
  //       }
  //       res = "Sign Up Success";
  //     } else {
  //       res = "You are not authorised to Sign up";
  //     }
  //   } catch (err) {
  //     res = err.toString();
  //   }
  //   return res;
  // }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some Error Occurred";
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = "Log In Success";
      } else {
        res = "Enter email and password";
      }
    } on FirebaseAuthException catch(err) {
      res = err.code.toString();
    }
    return res;
  }

  Future<String> logoutUser() async {
    String res = "Some Error Occured";
    try {
      await _auth.signOut();
      await AuthService().signOutWithGoogle();
      res = "Log Out Success";
    } on FirebaseAuthException catch(err) {
      res = err.code.toString();
      print(res);
    }
    return res;
  }

  Future<String> changeState(
    String key, String value, Map<String, dynamic> userMap) async {
    String res = "Some Error Occured";
    try {
      userMap[key] = value;
      await _firestore.collection('users').doc(userMap['uid']).set(userMap);
      res = "Update Success";
    } catch (err) {
      res = err.toString();
    }
    print(res);
    return res;
  }

  Future<String> changeAdminState(
    String key, String value, Map<String, dynamic> userMap) async {
    String res = "Some Error Occured";
    try {
      userMap[key] = value;
      await _firestore.collection('admin').doc(userMap['uid']).set(userMap);
      res = "Update Success";
    } catch (err) {
      res = err.toString();
    }

    print(res);
    return res; 
  }

  // Future<String> changeComplaintState(
  //     String key, dynamic value, Map<String, dynamic> userMap) async {
  //   String res = "Some Error Occured";
  //   try {
  //     userMap[key] = value;
  //     await _firestore
  //         .collection('complaints')
  //         .doc(userMap['compId'])
  //         .set(userMap);
  //     res = "Update Success";
  //   } catch (err) {
  //     res = err.toString();
  //   }
  //   print(res);
  //   return res;
  // }
}
