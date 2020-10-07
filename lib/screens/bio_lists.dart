import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dailybio/constants.dart';
import 'package:dailybio/models/Bio.dart';
import 'package:dailybio/screens/idcart.dart';
import 'package:dailybio/services/firebase_auth.dart';
import 'package:dailybio/services/firebase_service.dart';
import 'package:dailybio/widgets/BioDrawer.dart';
import 'package:flutter/material.dart';
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
          backgroundColor: Color(0xffF7F8F9),
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
                    background: Image(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/storage.jpg'),
                    ),
                  ),
                ),
              ];
            },
            body: SafeArea(
              child: Container(
                child: FutureBuilder(
                    future: firebaseService.collectionReference.get(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            reverse: false,
                            itemCount: snapshot.data.size,
                            itemBuilder: (context, index) {
                              count_page = snapshot.data.size;
                              return IDCart(
                                Bio(
                                  dates: snapshot.data.docs[index].get('dates'),
                                  heroName: snapshot.data.docs[index]
                                      .get('hero_name'),
                                  releaseDate: snapshot.data.docs[index]
                                      .get('releaseDate'),
                                  index: snapshot.data.docs[index].get('index'),
                                  likes: snapshot.data.docs[index].get('likes'),
                                  honour:
                                      snapshot.data.docs[index].get('honour'),
                                  profile_photo: snapshot.data.docs[index]
                                      .get('profile_photo'),
                                ),
                              );
                            });
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.amber,
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
