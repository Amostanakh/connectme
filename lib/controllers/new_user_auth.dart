import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class UserManagement {
  storeNewUser(user, context) async {
    User? currentFirebaseUser = FirebaseAuth.instance.currentUser;

    // Reference to the Realtime Database
    DatabaseReference usersRef = FirebaseDatabase.instance.ref("users");

    // Create a new user entry in the database
    await usersRef.child(currentFirebaseUser!.uid).set({
      'email': user.email,
      'uid': user.uid,
      'friends': [],
      'favourites': [],
    }).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User data stored successfully.')),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error storing user data: $error')),
      );
    });
  }
}
