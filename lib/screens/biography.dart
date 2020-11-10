import 'package:cached_network_image/cached_network_image.dart';
import 'package:dailybio/constants.dart';
import 'package:dailybio/models/Bio.dart';
import 'package:dailybio/services/firebase_auth.dart';
import 'package:dailybio/widgets/BioDrawer.dart';
import 'package:dailybio/widgets/PersistentHeader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meet_network_image/meet_network_image.dart';
import 'package:provider/provider.dart';
import 'package:dailybio/main.dart';

class Biography extends StatefulWidget {
  @override
  _BiographyState createState() => _BiographyState();

  final Bio bio;
  Biography({this.bio});
}

class _BiographyState extends State<Biography>
    with SingleTickerProviderStateMixin {
  // Relase date editer.
  String setReleaseDate() {
    if (widget.bio.releaseDate.toDate().day == DateTime.now().day)
      return 'Bugün';
    else if (widget.bio.releaseDate.toDate().day == DateTime.now().day - 1)
      return 'Dün';

    setState(() {});
  }

  //initstate

  @override
  void initState() {
    super.initState();
  }

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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
          drawer: Drawer(
            child: BioDrawer(),
          ),
          key: _scaffoldKey,
          drawerEnableOpenDragGesture: false,
          backgroundColor: Color(0xffecf4f3),
          body: Container(
            child: NestedScrollView(
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      //Like and share bar
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.all(6.0),
                        height: 70,
                        width: deviceWidth * 8.5 / 10,
                        decoration: BoxDecoration(
                          color: Color(0xff006a71),
                          borderRadius: BorderRadius.all(
                            Radius.circular(16.0),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  icon: auth.currentUser != null
                                      ? widget.bio.likes
                                              .contains(auth.currentUser.uid)
                                          ? FaIcon(
                                              FontAwesomeIcons.solidHeart,
                                              size: 22,
                                              color: Color(0xffff7e67),
                                            )
                                          : FaIcon(
                                              FontAwesomeIcons.heartBroken,
                                              size: 22,
                                              color: Colors.white,
                                            )
                                      : FaIcon(
                                          FontAwesomeIcons.heartBroken,
                                          size: 22,
                                          color: Colors.white,
                                        ),
                                  onPressed: () {
                                    if (auth.currentUser != null) {
                                      if (widget.bio.likes
                                          .contains(auth.currentUser.uid)) {
                                        widget.bio.likes
                                            .remove(auth.currentUser.uid);

                                        // update likes
                                        setState(() {});
                                      } else {
                                        widget.bio.likes
                                            .add(auth.currentUser.uid);
                                        //update likes
                                        setState(() {});
                                      }
                                      widget.bio.updateLikes();
                                    } else {
                                      Navigator.pushNamed(context, 'register');
                                    }
                                  },
                                ),
                                Text(
                                  '${widget.bio.likes.length}',
                                  style:
                                      GoogleFonts.sourceSansPro(fontSize: 17),
                                )
                              ],
                            ),
                            IconButton(
                                icon: FaIcon(
                                  FontAwesomeIcons.shareAlt,
                                  size: 22,
                                  color: Color(0xffff7e67),
                                ),
                                onPressed: () {
                                  widget.bio.shareBiyography(context);
                                }),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xffecf4f3),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
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
                                color: Color(0xffff7e67),
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                          backgroundColor: Color(0xffecf4f3),
                        ),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Center(
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 3000),
                          decoration: BoxDecoration(
                            color: Color(0xffecf4f3),
                          ),
                          width: deviceWidth * 9.5 / 10,
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                                child: Column(
                                  children: [
                                    for (var block in widget.bio.text)
                                      Text(
                                        block + '\n',
                                        style: GoogleFonts.sourceSerifPro(
                                            color: Colors.black,
                                            fontSize: font_size),
                                      ),
                                  ],
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
                                color: Color(0xffff7e67),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),

                //Appbar and persistent header of biography.

                headerSliverBuilder:
                    (BuildContext context, bool innerBoxScrolled) {
                  return [
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      leading: Builder(
                        builder: (BuildContext context) {
                          return Container(
                            margin: EdgeInsets.fromLTRB(12.0, 6, 0, 6),
                            color: Color(0xffecf4f3),
                            child: IconButton(
                              icon: const Icon(FontAwesomeIcons.bars),
                              onPressed: () {
                                _scaffoldKey.currentState.openDrawer();
                              },
                              tooltip: MaterialLocalizations.of(context)
                                  .openAppDrawerTooltip,
                            ),
                          );
                        },
                      ),
                      iconTheme: IconThemeData(color: Colors.brown),
                      flexibleSpace: FlexibleSpaceBar(
                        collapseMode: CollapseMode.parallax,
                        background: PreferredSize(
                          child: Container(
                            color: Color(0xffecf4f3),
                            margin: EdgeInsets.all(8.0),
                            // child: MeetNetworkImage(
                            //   gaplessPlayback: true,
                            //   fit: BoxFit.cover,
                            //   imageUrl: widget.bio.picture,
                            //   loadingBuilder: (context) => Center(
                            //     child: SpinKitPouringHourglass(
                            //       color: Color(0xffff7e67),
                            //       size: 125,
                            //     ),
                            //   ),
                            //   errorBuilder: (context, e) => Center(
                            //     child: Text('Error appear!'),
                            //   ),
                            // ),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: widget.bio.picture,
                              placeholder: (context, string) => Center(
                                child: SpinKitPouringHourglass(
                                  color: Color(0xffff7e67),
                                  size: 125,
                                ),
                              ),
                            ),
                          ),
                          preferredSize: Size.fromHeight(300),
                        ),
                      ),
                      backgroundColor: Color(0xffecf4f3),
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
