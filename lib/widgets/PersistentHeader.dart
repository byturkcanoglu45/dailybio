import 'package:dailybio/constants.dart';
import 'package:dailybio/models/Bio.dart';
import 'package:dailybio/services/firebase_auth.dart';
import 'package:dailybio/screens/bio_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PersistentHeader extends SliverPersistentHeaderDelegate {
  final width;
  final releaseDate, hero_name, dates;

  PersistentHeader({this.releaseDate, this.hero_name, this.dates, this.width});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Align(
      alignment: Alignment.center,
      child: FittedBox(
        fit: BoxFit.cover,
        child: Container(
          width: width * 9.5 / 10,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            children: [
              Text(
                releaseDate,
                style: GoogleFonts.sourceSerifPro(
                    color: Colors.grey[400], fontSize: 20),
              ),
              Container(
                width: width * 9.5 / 20,
                child: Divider(
                  color: Colors.grey[500],
                ),
              ),
              Text(
                hero_name,
                style: GoogleFonts.sourceSerifPro(
                    color: Colors.black,
                    fontSize: 24,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w600),
              ),
              Container(
                width: width * 9.5 / 20,
                child: Divider(
                  color: Colors.grey[500],
                ),
              ),
              Text(
                dates,
                style: GoogleFonts.sourceSerifPro(
                    color: Colors.red[300],
                    fontSize: 20,
                    fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 150.0;

  @override
  double get minExtent => 100.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class RatingPersistentHeader extends SliverPersistentHeaderDelegate {
  RatingPersistentHeader({this.width, this.bio});
  final width;
  Bio bio;

  @override
  double get minExtent => 50;

  @override
  double get maxExtent => 100;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        height: 70,
        width: width * 9.5 / 10,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.heart,
                      size: 22,
                      color: bio.isLiked ? Colors.red : Colors.black,
                    ),
                    onPressed: () {
                      print(bio.isLiked);
                      if (bio.isLiked) {
                        bio.likes--;
                        bio.isLiked = false;
                        Provider.of<AuthService>(context, listen: false)
                            .user
                            .liked_biographies
                            .add(bio.index);

                        Provider.of<AuthService>(context)
                            .updateLikedBiographies();
                        print('Liked');
                      } else {
                        bio.likes++;
                        bio.isLiked = true;
                        Provider.of<AuthService>(context, listen: false)
                            .user
                            .liked_biographies
                            .remove(bio.index);
                        Provider.of<AuthService>(context)
                            .updateLikedBiographies();
                        print('unliked');
                      }
                    }),
                Text(
                  '${bio.likes}',
                  style: GoogleFonts.sourceSansPro(fontSize: 17),
                )
              ],
            ),
            IconButton(
                icon: FaIcon(
                  FontAwesomeIcons.shareAlt,
                  size: 22,
                ),
                onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
