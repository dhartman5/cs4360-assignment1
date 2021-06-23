import 'package:assignment1/models/user.dart';
// import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
      User? user = result.user;
      print('Successfully logged in, User UID: ${user!.uid}');
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
  // sign in with google

  // register with email and pass

  // auth change user stream

  // Stream<MyUser> get user {
  //   return _auth
  //       .authStateChanges()
  //       .map((User user) => _userFromFirebaseUser(user));
  //   // .map(_userFromFirebaseUser);
  // }

  // sign out
  // Future signOut() async {
  //   try {
  //     return await _auth.signOut();
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }
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
