import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dailybio/models/Bio.dart';
import 'package:dailybio/screens/biography.dart';
import 'package:dailybio/services/firebase_auth.dart';
import 'package:dailybio/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BioPages extends StatefulWidget {
  @override
  _BioPagesState createState() => _BioPagesState();
}

//Page numbers and indexs.
int count_page;

//Page controller to controll page builder.
PageController pageController = PageController();

class _BioPagesState extends State<BioPages> {
  @override
  void initState() {
    super.initState();
    signIn();
  }

  //The service that takes data from database.
  FirebaseService firebaseService = FirebaseService();

  //Sign in each time when app opened.

  signIn() async {
    await Provider.of<AuthService>(context, listen: false).signInAnonymously();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(
      builder: (context, provider, child) {
        return Scaffold(
          body: Container(
            child: FutureBuilder(
                future: firebaseService.collectionReference.get(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  count_page = snapshot.data.size;
                  if (snapshot.hasData) {
                    return PageView.builder(
                        controller: pageController,
                        itemCount: snapshot.data.size ?? 0,
                        itemBuilder: (context, index) {
                          return Biography(
                            bio: Bio(
                              dates: snapshot.data.docs[index].get('dates'),
                              heroName:
                                  snapshot.data.docs[index].get('hero_name'),
                              releaseDate:
                                  snapshot.data.docs[index].get('releaseDate'),
                              text: snapshot.data.docs[index].get('text'),
                              picture: snapshot.data.docs[index].get('picture'),
                              index: snapshot.data.docs[index].get('index'),
                              likes: snapshot.data.docs[index].get('likes'),
                              isLiked: provider.user.liked_biographies.contains(
                                      snapshot.data.docs[index].get('index'))
                                  ? true
                                  : false,
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
        );
      },
    );
  }
}
