import 'package:assignment1/models/user.dart';
import 'package:assignment1/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rxdart/rxdart.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  // create user obj based on FirebaseUser
  MyUser? _userFromFirebase(User? user) {
    print("Pulling user: $user from FireBaseAuth.");
    return user != null
        ? MyUser(
            uid: user.uid,
            registrationDate: user.metadata.creationTime,
          )
        : null;
  }

  // auth change user stream
  Stream<MyUser?> get user {
    return _auth.authStateChanges().map(_userFromFirebase);
  }

  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInAnonymously();
      User user = userCredential.user!;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and pass
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? currUser = result.user;
      print('Successfully logged in, User UID: ${currUser!.uid}');
      return _userFromFirebase(currUser);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // sign in with google
  Future signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser!.authentication;
      final AuthCredential? credential = GoogleAuthProvider.credential(
        idToken: googleAuth!.idToken,
        accessToken: googleAuth.accessToken,
      );

      // Firebase signin
      final result = await _auth.signInWithCredential(credential!);
      print('${result.user!.displayName}');
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // register with email and pass
  Future registerWithEmailAndPassword(String email, String password,
      String firstName, String lastName, DateTime dateRegistered) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? currUser = result.user;
      // create a new document based on new user
      await DataBaseService(uid: currUser?.uid as String)
          .updateUserData(firstName, lastName, 'Customer', dateRegistered);
      return _userFromFirebase(currUser);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

// sign out
  Future signOut() async {
    try {
      print('User signed out');
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
