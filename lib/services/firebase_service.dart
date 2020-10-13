import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dailybio/models/Bio.dart';

class FirebaseService {
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('biographies');

  CollectionReference userReference =
      FirebaseFirestore.instance.collection('users');

  CollectionReference likesReference =
      FirebaseFirestore.instance.collection('likes');

  retriveFromData() async {
    await collectionReference.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.map((element) {
        Bio(
            dates: element.data()['dates'],
            heroName: element.data()['hero_name'],
            releaseDate: element.data()['releaseDate'],
            text: element.data()['text']);
      });
    });
    // print(bio_list.length);
  }
}
