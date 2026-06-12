import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';


class SocialAuthenticationController extends GetxController{

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Begin interactive sign in process
      log("==================Here 1================");
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return null;
      }

      log("==================Here 2================");
      // Obtain auth details from request
      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      log("==================Here 3================");
      // If both tokens are missing, do NOT create a credential
      final String? accessToken = googleAuth.accessToken;
      final String? idToken = googleAuth.idToken;
      if ((accessToken == null || accessToken.isEmpty) &&
          (idToken == null || idToken.isEmpty)) {
        // This can happen if the flow was interrupted — treat as cancel/failure
        return null;
      }

      log("==================Here 4================");

      // Create Firebase credential and sign in for User
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: accessToken,
        idToken: idToken,
      );

      log("==================Here 5================");
      // finally sign in user with credential
      return await firebaseAuth.signInWithCredential(credential);
    } catch (e) {
      // Optional: log or show a toast/snackbar
      log('Google sign-in error: $e');
      return null;
    }
  }
}