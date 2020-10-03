import 'package:dailybio/models/Bio.dart';
import 'package:dailybio/services/firebase_auth.dart';
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
    checkOffSet();
  }

  String release_date;
  double deviceWidth, pixelRatio;

  // Check the scroll.
  ScrollController controller = ScrollController();

  //Watcher for offset.
  bool watchset = false;

  // Check the offset.
  void checkOffSet() {
    controller.addListener(() {
      setState(() {
        controller.offset > 1000 ? watchset = true : watchset = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    pixelRatio = MediaQuery.of(context).size.width;
    release_date = setReleaseDate();

    return Consumer<AuthService>(
      builder: (context, user_provider, child) {
        return Scaffold(
          drawerEnableOpenDragGesture: false,
          drawer: Drawer(),
          backgroundColor: Colors.white,
          body: Container(
            child: CustomScrollView(
              controller: controller,
              shrinkWrap: true,
              slivers: [
                // Appbar
                SliverAppBar(
                  flexibleSpace: FlexibleSpaceBar(
                    background: PreferredSize(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue[300],
                          borderRadius: BorderRadius.circular(6.0),
                          image: DecorationImage(
                            image: NetworkImage(widget.bio.picture),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      preferredSize: Size.fromHeight(300),
                    ),
                  ),
                  backgroundColor: Colors.blue[300],
                  //snap: true,

                  elevation: 0,
                  floating: true,
                  pinned: true,
                  expandedHeight: 450,
                ),

                //Auto size header
                SliverPersistentHeader(
                  //floating: true,
                  pinned: true,
                  delegate: PersistentHeader(
                      width: deviceWidth,
                      releaseDate: release_date ?? widget.bio.getReleaseDate(),
                      hero_name: widget.bio.heroName.toUpperCase(),
                      dates: widget.bio.dates),
                ),

                //Ratings
                /*  SliverPersistentHeader(
              pinned: false,
              delegate:
                  RatingPersistentHeader(width: deviceWidth, bio: widget.bio),
            ),*/

                // Like calculator.
                SliverList(
                  delegate: SliverChildListDelegate([
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 70,
                        width: deviceWidth * 9.5 / 10,
                        decoration: BoxDecoration(
                          color: Colors.blue[300],
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
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
                                      color: widget.bio.isLiked
                                          ? Colors.red
                                          : Colors.black,
                                    ),
                                    onPressed: () {
                                      print(widget.bio.isLiked);
                                      if (widget.bio.isLiked) {
                                        widget.bio.likes--;
                                        widget.bio.isLiked = false;
                                        widget.bio.changeLikes(widget.bio);

                                        user_provider.user.liked_biographies
                                            .remove(widget.bio.index);

                                        user_provider.updateLikedBiographies();
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
                                        user_provider.updateLikedBiographies();
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
                                ),
                                onPressed: () {}),
                          ],
                        ),
                      ),
                    ),
                  ]),
                ),

                //Sliver List
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      ExpansionTile(
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
                        backgroundColor: Colors.blue[300],
                      ),
                      Center(
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 3000),
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          width: watchset
                              ? deviceWidth * 9.5 / 10
                              : deviceWidth * 9.5 / 10,
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.all(15),
                                child: Text(
                                  widget.bio.text,
                                  style: GoogleFonts.sourceSerifPro(
                                      color: Colors.black, fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
