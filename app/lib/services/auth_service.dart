import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
//import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import 'constants.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> signup(String name, String email, String password) async {
    try {
      var authResult = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      if (authResult.user != null) {
        String? token = await _firebaseMessaging.getToken();
        usersRef.doc(authResult.user!.uid).set({
          'name': name,
          'email': email,
          'profileImageUrl': '',
          'bio': '',
          'token': token,
        });
        debugPrint('Signup complete');
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> login(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      debugPrint('login complete');
    } catch (error) {
      rethrow;
    }
  }

  Future<void> logout() async {
    Future.wait([_firebaseAuth.signOut()]);
  }

  Future<UserCredential> signInWithGoogle() async {
    GoogleSignInAccount? _googleUser = await GoogleSignIn().signIn();

    GoogleSignInAuthentication? _googleAuth = await _googleUser?.authentication;

    debugPrint("[GoogleSignInAuthentication works!]");
    final _credentials = GoogleAuthProvider.credential(
        accessToken: _googleAuth?.accessToken, idToken: _googleAuth?.idToken);
    debugPrint("[GoogleSignInAuthentication works!]");
    var user = await FirebaseAuth.instance.signInWithCredential(_credentials);

    /* Create the user credentials */
    if (user.user != null) {
      var userInfo = user.user!;
      var doc = await usersRef.doc(user.user!.uid).get();
      if (!doc.exists) {
        usersRef.doc(userInfo.uid).set({
          'name': userInfo.displayName,
          'email': userInfo.email,
          'profileImageUrl': userInfo.photoURL,
          'bio': '',
        });
      }
    }

    return user;
  }
}
