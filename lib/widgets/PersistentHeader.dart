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
    return FittedBox(
      fit: BoxFit.cover,
      child: Container(
        margin: EdgeInsets.all(6.0),
        width: width * 9.5 / 10,
        decoration: BoxDecoration(
          color: Color(0xffecf4f3),
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
                  fontWeight: FontWeight.w700),
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
    );
  }

  @override
  double get maxExtent => 150.0;

  @override
  double get minExtent => 150.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
