import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dailybio/services/DatabaseService.dart';
import 'package:dailybio/services/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

// Is user logged in or not.
bool loggedIn = false;

class AuthService with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  User user;

  //Google object configurations.
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  // Create Anonymous account
  signUpAnonymously() async {
    var firebaseUser = await auth.signInAnonymously();
    user = User(uid: firebaseUser.user.uid);
    FirebaseService().userReference.doc(user.uid).set(
      {'liked_biographies': user.liked_biographies},
    );
    notifyListeners();
    print('User Created');
  }

  // Sign in with current user if not logged in.
  signInAnonymously() async {
    if (auth.currentUser != null) {
      var firebaseUser = auth.currentUser;
      user = User(
        uid: firebaseUser.uid,
      );

      getLikedBios();
      print('User logged in');
    } else {
      signUpAnonymously();
    }
    notifyListeners();
  }

  //Sign in with Google.

  signInGoogle() async {
    try {
      var google_user = await _googleSignIn.signIn();
      user = User(
        uid: google_user.id,
        email: google_user.email,
        nickname: google_user.displayName,
      );
      FirebaseService().userReference.doc(user.uid).set({
        'nickname': user.nickname,
        'liked_biographies': user.liked_biographies,
      });
      loggedIn = true;
    } catch (error) {
      print(error);
    }
    notifyListeners();
  }

  registerEmail(String email, String password, String name) async {
    var firebaseUser = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    firebaseUser.user.updateProfile(displayName: name);
    print('auth' + auth.currentUser.toString());
    print('firebase : ' + firebaseUser.user.toString());

    user = User(
        email: email,
        uid: firebaseUser.user.uid,
        nickname: firebaseUser.user.displayName);
    FirebaseService().userReference.doc(user.uid).set({
      'liked_biographies': user.liked_biographies,
    });
    loggedIn = true;
    await DatabaseService().saveSettings();

    notifyListeners();
  }

  //Sign in with email and password.

  logInEmail(String email, String password) async {
    var firebaseUser =
        await auth.signInWithEmailAndPassword(email: email, password: password);

    user = User(
        email: email,
        uid: firebaseUser.user.uid,
        nickname: firebaseUser.user.displayName);
    getLikedBios();
    loggedIn = true;
    await DatabaseService().saveSettings();

    notifyListeners();
  }

  // To log out from all accounts.

  logOut() async {
    await auth.signOut();
    loggedIn = false;
    await DatabaseService().saveSettings();
  }

  getLikedBios() async {
    var liked_bios = await FirebaseService()
        .userReference
        .doc(user.uid)
        .get(GetOptions(source: Source.server))
        .then((value) => value.get('liked_biographies'));

    user.liked_biographies = await liked_bios;
    print(user.liked_biographies);

    notifyListeners();
  }

  updateLikedBiographies() async {
    FirebaseService().userReference.doc(user.uid).update({
      'liked_biographies': user.liked_biographies,
    });
    notifyListeners();
  }
}

class User {
  String nickname;
  String uid;
  String email;

  User({this.uid, this.email, this.nickname});

  var liked_biographies = [];

  toStringList() {
    liked_biographies.map((e) => e.toString());
    List<String> user_list = [this.nickname, this.uid, this.email];
  }
}
