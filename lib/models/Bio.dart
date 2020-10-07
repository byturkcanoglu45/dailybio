import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dailybio/constants.dart';
import 'package:dailybio/services/firebase_service.dart';

class Bio {
  Timestamp releaseDate;
  String text, heroName, dates, picture, source, profile_photo, honour;
  int index;
  int likes;
  bool isLiked;
  List quotes = [];

  Bio({
    this.releaseDate,
    this.heroName,
    this.dates,
    this.text,
    this.picture,
    this.index,
    this.likes,
    this.isLiked,
    this.source,
    this.quotes,
    this.profile_photo,
    this.honour,
  });

  String getReleaseDate() {
    var rday = releaseDate.toDate().day.toString();
    var rmonth = month_cover(releaseDate.toDate().month);
    var ryear = releaseDate.toDate().year.toString();

    return rday + ' ' + rmonth + ' ' + ryear;
  }

  changeLikes(Bio bio) async {
    try {
      await FirebaseService()
          .collectionReference
          .doc('deneme${bio.index}')
          .update(
        {
          'likes': bio.likes,
        },
      );
    } catch (e) {
      print(e);
    }
  }
}
