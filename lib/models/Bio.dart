import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dailybio/constants.dart';
import 'package:dailybio/services/firebase_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:share/share.dart';

class Bio {
  Timestamp releaseDate;
  String heroName, dates, picture, source, profile_photo, honour;
  int index;
  int likes;
  var text;

  bool isLiked;
  List quotes = [];

  Bio({
    this.releaseDate,
    this.heroName,
    this.dates,
    this.text,
    this.picture,
    this.index,
    this.isLiked,
    this.source,
    this.quotes,
    this.profile_photo,
    this.honour,
    this.likes,
  });

  String getReleaseDate() {
    var rday = releaseDate.toDate().day.toString();
    var rmonth = month_cover(releaseDate.toDate().month);
    var ryear = releaseDate.toDate().year.toString();

    return rday + ' ' + rmonth + ' ' + ryear;
  }

  getLikes() async {
    this.likes = await FirebaseService()
        .likesReference
        .get()
        .then((value) => value.docs[index].get('likes'));
  }

  changeLikes(Bio bio) async {
    try {
      await FirebaseService()
          .likesReference
          .doc('biyography${bio.index + 1}')
          .update(
        {
          'likes': bio.likes,
        },
      );
    } catch (e) {
      print(e);
    }
  }

  shareBiyography(BuildContext context) {
    final RenderBox box = context.findRenderObject();
    Share.share(
      "${this.getReleaseDate()} Tarihli ${this.heroName} Biyografisini okumanı tavsiye ediyorum. 🤓🤓\n Uygulamayı bu linkten indirebilirsin : https://play.google.com/store/apps/details?id=cecilrhodes.dailybio",
      subject: this.heroName,
      sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
    );
  }
}
