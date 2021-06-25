import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gezdostumblog/models/members.dart';

import 'firebase_store.dart';

class FireBaseSignIn {
  FireBaseStore fbStore = new FireBaseStore();

  Future<void> createMember(
      Members user, VoidCallback successful, VoidCallback unSuccessful) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: user.getEmail, password: user.getPassword)
        .then((value) {
      fbStore.setUserInfo(user);
      successful();
    }).catchError((onError) {
      unSuccessful();
    });
  }

  Future<void> signInMember(String email, String password,
      VoidCallback successful, VoidCallback unSuccessful) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) => successful())
        .catchError((onError) => unSuccessful);
  }
}
