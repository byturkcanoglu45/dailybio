import 'package:dailybio/constants.dart';
import 'package:dailybio/models/Bio.dart';
import 'package:dailybio/services/firebase_auth.dart';
import 'package:dailybio/widgets/BioDrawer.dart';
import 'package:dailybio/widgets/PersistentHeader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Biography extends StatefulWidget {
  @override
  _BiographyState createState() => _BiographyState();

  final Bio bio;
  Biography({this.bio});
}

class _BiographyState extends State<Biography> {
  // Relase date editer.
  String setReleaseDate() {
    if (widget.bio.releaseDate.toDate().day == DateTime.now().day)
      return 'Today';
    else if (widget.bio.releaseDate.toDate().day == DateTime.now().day - 1)
      return 'Yesterday';

    setState(() {});
  }

  //initstate

  @override
  void initState() {
    super.initState();
  }

  String release_date;
  double deviceWidth, pixelRatio;

  @override
  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    pixelRatio = MediaQuery.of(context).size.width;
    release_date = setReleaseDate();

    return Consumer<AuthService>(
      builder: (context, user_provider, child) {
        return Scaffold(
          drawerEnableOpenDragGesture: false,
          drawer: Drawer(
            child: BioDrawer(),
          ),
          backgroundColor: Colors.white,
          body: Container(
            child: NestedScrollView(
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: 70,
                          width: deviceWidth * 9.5 / 10,
                          decoration: BoxDecoration(
                            color: Colors.green[200],
                            borderRadius: BorderRadius.all(
                              Radius.zero,
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                      icon: widget.bio.isLiked
                                          ? FaIcon(
                                              FontAwesomeIcons.solidHeart,
                                              size: 22,
                                              color: Colors.red,
                                            )
                                          : FaIcon(
                                              FontAwesomeIcons.heartBroken,
                                              size: 22,
                                              color: Colors.white,
                                            ),
                                      onPressed: () {
                                        if (widget.bio.isLiked) {
                                          widget.bio.likes--;
                                          widget.bio.isLiked = false;
                                          widget.bio.changeLikes(widget.bio);

                                          user_provider.user.liked_biographies
                                              .remove(widget.bio.index);

                                          user_provider
                                              .updateLikedBiographies();
                                          print('updated');
                                        } else if (!widget.bio.isLiked) {
                                          widget.bio.likes++;
                                          widget.bio.isLiked = true;
                                          widget.bio.changeLikes(widget.bio);

                                          if (!user_provider
                                              .user.liked_biographies
                                              .contains(widget.bio.index)) {
                                            user_provider.user.liked_biographies
                                                .add(widget.bio.index);
                                          }
                                          user_provider
                                              .updateLikedBiographies();
                                          print('updated');
                                        }
                                        setState(() {});
                                      }),
                                  Text(
                                    '${widget.bio.likes}',
                                    style:
                                        GoogleFonts.sourceSansPro(fontSize: 17),
                                  )
                                ],
                              ),
                              IconButton(
                                  icon: FaIcon(
                                    FontAwesomeIcons.shareAlt,
                                    size: 22,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {}),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        width: deviceWidth * 9.5 / 10,
                        child: ExpansionTile(
                          childrenPadding: EdgeInsets.all(6.0),
                          children: [
                            for (var quote in widget.bio.quotes)
                              Text(
                                '"' + quote + '"\n',
                                style: kGoogleFont.copyWith(
                                  fontSize: 18,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.grey,
                                ),
                              ),
                          ],
                          title: Center(
                            child: Text(
                              'Kişinin Sözleri',
                              style: GoogleFonts.sourceSansPro(
                                fontSize: 18,
                                color: Colors.red,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                          backgroundColor: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Center(
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 3000),
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          width: deviceWidth * 9.5 / 10,
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                                child: Text(
                                  widget.bio.text,
                                  style: GoogleFonts.sourceSerifPro(
                                      color: Colors.black, fontSize: font_size),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '\nKaynak:\n',
                              style: kGoogleFont.copyWith(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: widget.bio.source,
                              style: kGoogleFont.copyWith(
                                  color: Colors.blue,
                                  fontStyle: FontStyle.italic),
                            ),
                            TextSpan(
                              text: '\nEkleyen:\n',
                              style: kGoogleFont.copyWith(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: 'CR Studio',
                              style: kGoogleFont.copyWith(
                                fontSize: 18,
                              ),
                            ),
                            TextSpan(
                              text: '\nEklenme Tarihi:\n',
                              style: kGoogleFont.copyWith(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: widget.bio.getReleaseDate(),
                              style: kGoogleFont.copyWith(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxScrolled) {
                  return [
                    SliverAppBar(
                      iconTheme: IconThemeData(color: Colors.brown),
                      flexibleSpace: FlexibleSpaceBar(
                        collapseMode: CollapseMode.parallax,
                        background: PreferredSize(
                          child: Image(
                            fit: BoxFit.cover,
                            image: NetworkImage(widget.bio.picture),
                          ),
                          preferredSize: Size.fromHeight(300),
                        ),
                      ),
                      backgroundColor: Colors.blue[300],
                      snap: false,
                      elevation: 200,
                      floating: true,
                      pinned: false,
                      expandedHeight: 450,
                    ),
                    SliverPersistentHeader(
                      floating: true,
                      pinned: true,
                      delegate: PersistentHeader(
                          width: deviceWidth,
                          releaseDate:
                              release_date ?? widget.bio.getReleaseDate(),
                          hero_name: widget.bio.heroName.toUpperCase(),
                          dates: widget.bio.dates),
                    ),
                  ];
                }),
          ),
        );
      },
    );
  }
}
