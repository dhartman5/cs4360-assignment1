import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseService {
  final String uid;
  DataBaseService({required this.uid});

  // collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future updateUserData(String firstName, String lastName, String role,
      DateTime dateRegistered) async {
    return await userCollection.doc(uid).set({
      'First Name': firstName,
      'Last Name': lastName,
      'Role': 'Customer',
      'Date Registered': dateRegistered,
    });
  }
}
