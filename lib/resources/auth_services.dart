import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:helping_hand/models/organisation.dart';
import 'package:helping_hand/models/user.dart' as model;

class AuthService {
  //Instance of firebase authentication
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Instance of google authentication
  static final GoogleSignIn _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? gUser;
  GoogleSignInAuthentication? gAuth;

  //google sign in
  signInWithGoogle() async{
    //begin interactive sign in process
    gUser = await _googleSignIn.signIn();

    //obtain auth details from request
    gAuth = await gUser!.authentication;

    //create a new credential for user
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth!.accessToken,
      idToken: gAuth!.idToken,
    );

    //finally, lets sign in
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  //google sign out
  signOutWithGoogle() async{
    // Sign out with google
    await _googleSignIn.signOut();
  }

  //method to get user details
  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snapshot =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.getUser(snapshot);
  }

  //method to get organisation details
  Future<Organisation> getOrganisationDetails() async {
    User currentOrg = _auth.currentUser!;

    DocumentSnapshot snapshot =
        await _firestore.collection('Organisation').doc(currentOrg.uid).get();

    return Organisation.getOrganisation(snapshot);
  }

  //method to sign up a new user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String location,
  }) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          location.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        model.User user = model.User(
          username: username,
          email: email,
          uid: cred.user!.uid, 
          interests: [], 
          skills: [], 
          volunteerHistory: [], 
          upcomingEvents: [], 
          following: [],
        );

        await _firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.getData());
        await _firestore
              .collection('type')
              .doc(cred.user!.uid)
              .set({'type':"user"});
      }
      res = "Sign Up Success";
    } catch (err) {
      res = err.toString();
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
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = "Log In Success";
      } else {
        res = "Enter email and password";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> logoutUser() async {
    String res = "Some Error Occured";
    try {
      await _auth.signOut();
      res = "Log Out Success";
    } catch (err) {
      res = err.toString();
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
