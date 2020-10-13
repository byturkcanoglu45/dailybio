import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dailybio/models/Bio.dart';

class FirebaseService {
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('biographies');

  CollectionReference userReference =
      FirebaseFirestore.instance.collection('users');

  CollectionReference likesReference =
      FirebaseFirestore.instance.collection('likes');
}
