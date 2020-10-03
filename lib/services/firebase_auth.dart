import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dailybio/services/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthService with ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User user;

  // Create Anonymous account
  signUpAnonymously() async {
    var firebaseUser = await _auth.signInAnonymously();
    user = User(uid: firebaseUser.user.uid);
    FirebaseService().userReference.doc(user.uid).set(
      {'liked_biographies': user.liked_biographies},
    );
    notifyListeners();
    print('User Created');
  }

  // Sign in with current user.
  signInAnonymously() async {
    if (_auth.currentUser != null) {
      var firebaseUser = await _auth.currentUser;
      user = User(uid: firebaseUser.uid);

      getLikedBios();
      print('User logged in');
    } else {
      signUpAnonymously();
    }
  }

  getLikedBios() async {
    var liked_bios = await FirebaseService()
        .userReference
        .doc(user.uid)
        .get(GetOptions(source: Source.server))
        .then((value) => value.data()['liked_biographies']);
    print(liked_bios);
    user.liked_biographies = liked_bios;
    notifyListeners();
  }

  updateLikedBiographies() async {
    FirebaseService().userReference.doc(user.uid).update({
      'liked_biographies': user.liked_biographies,
    });

    print(user.liked_biographies);
    notifyListeners();
  }
}

class User {
  String uid;
  String email;

  User({this.uid, this.email});

  var liked_biographies = [];
}
