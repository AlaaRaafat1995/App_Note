import 'package:app_note/auth/model.dart';
import 'package:app_note/styles/loading.dart';
import 'package:app_note/styles/navigation.dart';
import 'package:app_note/styles/snacke.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth {
// sign in

  signIn(context, String email, String password, Model usermodel,
      Widget route) async {
    UserCredential? credential;
    try {
      showLoading(context);
      credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      Navigation().navigateReplace(context, route);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        snake(context, "The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        snake(context, "The account already exists for that email.");
      }
    } catch (e) {
      print(e);
    }
    return credential;
  }

// log in

  logIn(context, String email, String password, Widget route) async {
    try {
      showLoading(context);
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      Navigation().navigateReplace(context, route);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        snake(context, "No user found for that email.");
      } else if (e.code == 'wrong-password') {
        snake(context, "Wrong password provided for that user.");
      }
    }
  }

// google sign in

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

// facebook sign in

  Future<UserCredential> signInWithFacebook() async {
    final LoginResult loginResult = await FacebookAuth.instance.login();

    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }
}
