import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dailybio/constants.dart';
import 'package:dailybio/models/Bio.dart';
import 'package:dailybio/screens/idcart.dart';
import 'package:dailybio/services/firebase_auth.dart';
import 'package:dailybio/services/firebase_service.dart';
import 'package:dailybio/widgets/BioDrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:dailybio/screens/bio_pages.dart';

class BioLists extends StatefulWidget {
  @override
  _BioListsState createState() => _BioListsState();
}

class _BioListsState extends State<BioLists> {
  FirebaseService firebaseService = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(
      builder: (context, provider, child) {
        return Scaffold(
          drawer: Drawer(
            child: BioDrawer(),
          ),
          backgroundColor: Color(0xffecf4f3),
          body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxScrolled) {
              return [
                SliverAppBar(
                  elevation: 0,
                  centerTitle: true,
                  title: Text(
                    'Arşiv',
                    style: kGoogleFont.copyWith(
                      color: Colors.brown,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  iconTheme: IconThemeData(
                    color: Colors.brown,
                    size: 30,
                    opacity: 200,
                  ),
                  expandedHeight: 100,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      margin: EdgeInsets.all(6.0),
                      child: Image(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/storage.jpg'),
                      ),
                    ),
                  ),
                  backgroundColor: Color(0xffecf4f3),
                ),
              ];
            },
            body: SafeArea(
              child: Container(
                child: FutureBuilder(
                    future: firebaseService.collectionReference
                        .orderBy('releaseDate', descending: true)
                        .get(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      print(snapshot.data.docs);
                      if (snapshot.hasData &&
                          snapshot.connectionState == ConnectionState.done) {
                        print(snapshot.data.docs);
                        return ListView.builder(
                            reverse: false,
                            itemCount: snapshot.data.size,
                            itemBuilder: (context, index) {
                              count_page = snapshot.data.size;
                              print(count_page);

                              return IDCart(
                                Bio(
                                  dates: snapshot.data.docs[index].get('dates'),
                                  heroName: snapshot.data.docs[index]
                                      .get('hero_name'),
                                  index: snapshot.data.docs[index].get('index'),
                                  honour:
                                      snapshot.data.docs[index].get('honour'),
                                  profile_photo: snapshot.data.docs[index]
                                      .get('profile_photo'),
                                ),
                              );
                            });
                      } else {
                        return Center(
                          child: SpinKitFadingCircle(
                            duration: Duration(seconds: 2),
                            color: Color(0xff006a71),
                          ),
                        );
                      }
                    }),
              ),
            ),
          ),
        );
      },
    );
  }
}
