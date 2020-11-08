import 'package:cached_network_image/cached_network_image.dart';
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
      elevation: 10.0,
      color: Color(0xffecf4f3),
      margin: EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 8.0),
      child: ListTile(
        onTap: () {
          print(this.bio.index);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BioPages(
                initialPage: this.bio.index,
              ),
            ),
          );
        },
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: CachedNetworkImageProvider(
            bio.profile_photo,
          ),
        ),
        title: Wrap(
          alignment: WrapAlignment.center,
          direction: Axis.vertical,
          children: [
            Text(
              bio.heroName.toUpperCase(),
              style: kGoogleFont2.copyWith(
                color: Color(0xff006a71),
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              bio.honour,
              style: kGoogleFont.copyWith(
                color: Color(0xff68b0ab),
                fontSize: 20,
              ),
            ),
            Text(
              bio.dates,
              style: kGoogleFont.copyWith(
                color: Color(0xffff7e67),
                fontSize: 20,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
