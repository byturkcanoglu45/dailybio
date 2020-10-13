import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dailybio/models/Bio.dart';
import 'package:dailybio/screens/biography.dart';
import 'package:dailybio/services/AdvertServices.dart';
import 'package:dailybio/services/DatabaseService.dart';
import 'package:dailybio/services/firebase_auth.dart';
import 'package:dailybio/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:rate_my_app/rate_my_app.dart';
import '../constants.dart';
import '../main.dart';

class BioPages extends StatefulWidget {
  @override
  _BioPagesState createState() => _BioPagesState();

  BioPages({this.initialPage});
  final initialPage;
}

//Page numbers and indexs.
int count_page = 0;

//Page controller to controll page builder.
PageController pageController;

class _BioPagesState extends State<BioPages> {
  @override
  void initState() {
    super.initState();
    showDailyAtTime();
    signIn();
    AdvertServices().showIntersitial();
    rateMyApp.init().then((_) {
      if (rateMyApp.shouldOpenDialog) {
        rateMyApp.showRateDialog(
          context,
          title: 'Bizi Puanla', // The dialog title.
          message:
              'Eğer bu uygulamayı seviyorsan, puanlamak için biraz vaktini ayırır mısın?\nDesteğin için teşekkürler!', // The dialog message.
          rateButton: 'ŞİMDİ PUANLA', // The dialog "rate" button text.
          noButton: 'HAYIR, TEŞEKKÜRLER', // The dialog "no" button text.
          laterButton: 'BELKİ SONRA', // The dialog "later" button text.
          listener: (button) {
            // The button click listener (useful if you want to cancel the click event).
            switch (button) {
              case RateMyAppDialogButton.rate:
                print('Clicked on "Rate".');
                break;
              case RateMyAppDialogButton.later:
                print('Clicked on "Later".');
                break;
              case RateMyAppDialogButton.no:
                print('Clicked on "No".');
                break;
            }

            return true; // Return false if you want to cancel the click event.
          },
          ignoreNativeDialog: Platform
              .isAndroid, // Set to false if you want to show the Apple's native app rating dialog on iOS or Google's native app rating dialog (depends on the current Platform).
          dialogStyle: DialogStyle(
            messageAlign: TextAlign.center,
            messageStyle: kGoogleFont.copyWith(color: Colors.red),
          ), // Custom dialog styles.
          onDismissed: () => rateMyApp.callEvent(RateMyAppEventType
              .laterButtonPressed), // Called when the user dismissed the dialog (either by taping outside or by pressing the "back" button).
          // contentBuilder: (context, defaultContent) => content, // This one allows you to change the default dialog content.
          // actionsBuilder: (context) => [], // This one allows you to use your own buttons.
        );
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  //The service that takes data from database.
  FirebaseService firebaseService = FirebaseService();

  //Sign in when app open.
  signIn() async {
    await Provider.of<AuthService>(context, listen: false).signInAnonymously();
    print(Provider.of<AuthService>(context, listen: false).auth.currentUser);
    await DatabaseService().getSettings();
  }

  //To get likes from reference.

  getLikes(int index) async {
    int likes = await firebaseService.likesReference
        .get()
        .then((value) => value.docs[index].get('likes'));

    return likes;
  }

  Bio biography;
  int current_reference = 0;
  String todays_name;

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(
      builder: (context, provider, child) {
        return Scaffold(
          body: Container(
            child: FutureBuilder<List<QuerySnapshot>>(
                future: Future.wait([
                  firebaseService.likesReference.get(),
                  firebaseService.collectionReference.get()
                ]),
                builder:
                    (context, AsyncSnapshot<List<QuerySnapshot>> snapshot) {
                  if (snapshot.hasData) {
                    count_page = snapshot.data[1].size;
                    pageController = PageController(
                        initialPage: widget.initialPage ?? count_page);
                    return PageView.builder(
                        onPageChanged: (int ind) {},
                        controller: pageController,
                        itemCount: snapshot.data[1].size ?? 0,
                        itemBuilder: (context, index) {
                          todays_name =
                              snapshot.data[1].docs[index].get('hero_name');
                          return Biography(
                              bio: Bio(
                            dates: snapshot.data[1].docs[index].get('dates'),
                            heroName:
                                snapshot.data[1].docs[index].get('hero_name'),
                            releaseDate:
                                snapshot.data[1].docs[index].get('releaseDate'),
                            text: snapshot.data[1].docs[index].get('text'),
                            picture:
                                snapshot.data[1].docs[index].get('picture'),
                            index: snapshot.data[1].docs[index].get('index'),
                            isLiked: provider.user.liked_biographies.contains(
                              snapshot.data[1].docs[index].get('index'),
                            )
                                ? true
                                : false,
                            source: snapshot.data[1].docs[index].get('source'),
                            quotes: snapshot.data[1].docs[index].get('quotes'),
                            likes: snapshot.data[0].docs[index].get('likes'),
                          ));
                        });
                  } else {
                    return Center(
                      child: SpinKitCubeGrid(
                        duration: Duration(seconds: 2),
                        color: Color(0xff006a71),
                      ),
                    );
                  }
                }),
          ),
        );
      },
    );
  }

  Future<void> showDailyAtTime() async {
    var time = Time(9, 15, 0);
    var androidChannelSpecifics = AndroidNotificationDetails(
      'DailyBio',
      'Günlük Biyografi',
      "",
      importance: Importance.max,
      priority: Priority.high,
    );
    var iosChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidChannelSpecifics, iOS: iosChannelSpecifics);
    await flutterLocalNotificationsPlugin.showDailyAtTime(
      0,
      '1Day 1Biography',
      '${todays_name} Hayat Hikayesi Hazır. 🤓🤓',
      time,
      NotificationDetails(
          android: androidChannelSpecifics, iOS: iosChannelSpecifics),
    );
  }
}
