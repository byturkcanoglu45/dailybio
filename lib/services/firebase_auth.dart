import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dailybio/services/DatabaseService.dart';
import 'package:dailybio/services/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class AuthService with ChangeNotifier {
  //Google object configurations.
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  //Sign in with Google.

  signInGoogle() async {
    try {
      var google_user = await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
    notifyListeners();
  }

  registerEmail(String email, String password, String name) async {
    await auth.createUserWithEmailAndPassword(email: email, password: password)
      ..user.updateProfile(displayName: name);

    print('auth' + auth.currentUser.toString());

    notifyListeners();
  }

  //Sign in with email and password.

  logInEmail(String email, String password) async {
    var firebaseUser =
        await auth.signInWithEmailAndPassword(email: email, password: password);

    await DatabaseService().saveSettings();

    notifyListeners();
  }

  // To log out from all accounts.

  logOut() async {
    await auth.signOut();
  }
}
