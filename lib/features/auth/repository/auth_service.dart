// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  FirebaseAuth auth;
  GoogleSignIn googleSignIn;

  // Created the constructor
  AuthService({
    required this.auth,
    required this.googleSignIn,
  });

  signInWithGoogle() async {
    // This will make the user to see all the google accounts that the user have and will store the result in the user variable
    final user = await googleSignIn.signIn();

    // the user will auithenticate now
    final googleAuth = await user!.authentication;

    // Credential is created
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // We will connect/store credential now with the firebase auth
    // By doing so we can sign in with google
    await auth.signInWithCredential(credential);
  }
}
