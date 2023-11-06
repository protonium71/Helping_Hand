import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
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

}