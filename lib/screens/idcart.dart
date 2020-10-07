import 'package:dailybio/models/Bio.dart';
import 'package:flutter/material.dart';
import 'package:dailybio/constants.dart';
import 'package:dailybio/screens/bio_pages.dart';

class IDCart extends StatelessWidget {
  IDCart(this.bio);

  final Bio bio;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 8.0),
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BioPages(
                initialPage: bio.index,
              ),
            ),
          );
        },
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(bio.profile_photo),
        ),
        title: Wrap(
          alignment: WrapAlignment.center,
          direction: Axis.vertical,
          children: [
            Text(
              bio.heroName.toUpperCase(),
              style: kGoogleFont.copyWith(
                color: Colors.black,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              bio.honour,
              style: kGoogleFont.copyWith(
                color: Colors.blue,
                fontSize: 18,
              ),
            ),
            Text(
              bio.dates,
              style: kGoogleFont.copyWith(
                color: Colors.redAccent,
                fontSize: 18,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
