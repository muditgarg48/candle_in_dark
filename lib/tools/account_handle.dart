// ignore_for_file: avoid_print, invalid_use_of_protected_member

import 'package:candle_in_dark/global_values.dart';
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
      isAdmin = false;
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
        AdminServices().checkAdmin();
        (context as Element).reassemble();
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
      rethrow;
    }
  }

  bool isGoogleSignedIn() {
    if (FirebaseAuth.instance.currentUser == null) {
      return false;
    } else if (isAdmin) {
      return false;
    } else {
      return true;
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
    isAdmin = false;
    (context as Element).reassemble();
  }
}

class AccountServices {
  bool isUserSignedIn() {
    if (FirebaseAuth.instance.currentUser == null) {
      return false;
    } else {
      return true;
    }
  }

  Future<bool> createUser(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("Welcome $email holder !");
      return true;
    } on FirebaseAuthException catch (e) {
      print("Error caught - $e");
      return false;
    }
  }
}

class AdminServices {
  var adminEmails = [
    "muditgarg48@gmail.com",
    "gargmu@tcd.ie",
    "mgarg3_be19@thapar.edu",
  ];

  Future<bool> checkAdmin(
      {String email = "null", String password = "null"}) async {
    if (email == "null" && password == "null") {
      if (adminEmails.contains(FirebaseAuth.instance.currentUser!.email)) {
        return true;
      } else {
        return false;
      }
    } else {
      bool couldLogin = await AccountServices().createUser(email, password);
      if (couldLogin) {
        return true;
      } else {
        return false;
      }
    }
  }

  void logoutAdmin() {
    FirebaseAuth.instance.signOut();
  }
}
