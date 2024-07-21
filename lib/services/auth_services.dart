// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: kIsWeb
        ? "221605114829-6ua8dalrtda4478o5o853vklkcmmfun4.apps.googleusercontent.com"
        : null,
  );

  // Google Sign-In
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? gUser = await _googleSignIn.signIn();
      if (gUser == null) {
        print("Google Sign-In aborted by user");
        return null;
      }

      final GoogleSignInAuthentication gAuth = await gUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      UserCredential userCredential = await _auth.signInWithCredential(credential);
      await _saveUserToFirestore(userCredential);
      return userCredential;
    } catch (e) {
      print("Google Sign-In failed: $e");
      return null;
    }
  }

  // Email/Password Sign-Up
  Future<UserCredential?> signUpWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _saveUserToFirestore(userCredential);
      return userCredential;
    } catch (e) {
      print("Sign-Up failed: $e");
      return null;
    }
  }

  // Email/Password Sign-In
  Future<UserCredential?> signInWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _saveUserToFirestore(userCredential);
      return userCredential;
    } catch (e) {
      print("Sign-In failed: $e");
      return null;
    }
  }

  // Send Password Reset Email
  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  // Get Current User
    User? getCurrentUser() {
      return _auth.currentUser;
    }

  // Get Current User ID
  String? getCurrentUserId() {
    return _auth.currentUser?.uid;
  }

  // Get Current User Email
  String? getCurrentUserEmail() {
    return _auth.currentUser?.email;
  }

  // Save user info to Firestore
  Future<void> _saveUserToFirestore(UserCredential userCredential) async {
    final user = userCredential.user;
    if (user != null) {
      await _firestore.collection("Users").doc(user.uid).set({
        'uid': user.uid,
        'email': user.email,
      }, SetOptions(merge: true)); // Use merge: true to update existing documents
    }
  }
}

