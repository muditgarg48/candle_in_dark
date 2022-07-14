// ignore_for_file: avoid_print, invalid_use_of_protected_member

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../widgets/toasts.dart';

class GoogleServices {
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn(
      clientId:
          "735354648960-i3u9pcodf16kin9fdgpb2itlog408b76.apps.googleusercontent.com");

  signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken);
        await _auth.signInWithCredential(authCredential);
        // print(googleSignInAccount);
        // print(googleSignInAccount.displayName);
        // print(googleSignInAccount.email);
        // print(googleSignInAccount.serverAuthCode);
        toast(
          context: context,
          msg: "Welcome ${googleSignInAccount.displayName} !",
          startI: Icons.login,
        );
        (context as Element).reassemble();
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
      rethrow;
    }
  }

  googleSignOut(BuildContext context) async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    toast(
      context: context,
      msg: "You successfully signed Out !",
      startI: Icons.logout,
    );
    (context as Element).reassemble();
  }

  bool isUserSignedIn() {
    if (FirebaseAuth.instance.currentUser == null) {
      return false;
    } else {
      return true;
    }
  }
}
