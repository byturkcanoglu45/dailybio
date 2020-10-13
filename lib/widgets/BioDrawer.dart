import 'dart:io';

import 'package:dailybio/screens/bio_pages.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dailybio/screens/bio_pages.dart';
import 'package:dailybio/services/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:dailybio/screens/bio_pages.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dailybio/constants.dart';

class BioDrawer extends StatefulWidget {
  @override
  _BioDrawerState createState() => _BioDrawerState();
}

class _BioDrawerState extends State<BioDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffecf4f3),
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xff006a71),
            ),
            child: ListView(
              children: [
                CircleAvatar(
                  radius: 45,
                  backgroundColor: Color(0xFFecf4f3),
                  child: Image(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/profile_logo.png'),
                  ),
                ),
                loggedIn
                    ? Wrap(
                        children: [
                          ListTile(
                            title: Text(
                              'Hoşgeldin ${Provider.of<AuthService>(context, listen: false).auth.currentUser.displayName ?? 'Misafir'}',
                              style: kGoogleFont.copyWith(
                                fontSize: 18,
                                color: Color(0xffecf4f3),
                              ),
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              Provider.of<AuthService>(context, listen: false)
                                  .logOut();

                              setState(() {});
                            },
                            leading: Icon(
                              FontAwesomeIcons.signInAlt,
                              color: Color(0xffecf4f3),
                            ),
                            title: Text(
                              'Çıkış yap',
                              style: kGoogleFont.copyWith(
                                fontSize: 18,
                                color: Color(0xffecf4f3),
                              ),
                            ),
                          ),
                        ],
                      )
                    : ListTile(
                        onTap: () {
                          Navigator.popAndPushNamed(context, 'login');
                        },
                        leading: Icon(
                          FontAwesomeIcons.signInAlt,
                          color: Color(0xffecf4f3),
                        ),
                        title: Text(
                          'Giriş yap veya kayıt ol',
                          style: kGoogleFont.copyWith(
                            fontSize: 18,
                            color: Color(0xffecf4f3),
                          ),
                        ),
                      ),
              ],
            ),
          ),
          ListTile(
            onTap: () {
              rateMyApp.init().then((_) {
                rateMyApp.showRateDialog(
                  context,
                  title: 'Bizi Puanla', // The dialog title.
                  message:
                      'Eğer bu uygulamayı seviyorsan, puanlamak için biraz vaktini ayırır mısın?\nDesteğin için teşekkürler!', // The dialog message.
                  rateButton: 'ŞİMDİ PUANLA', // The dialog "rate" button text.
                  noButton:
                      'HAYIR, TEŞEKKÜRLER', // The dialog "no" button text.
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
                    messageStyle:
                        kGoogleFont.copyWith(color: Colors.red, fontSize: 18),
                  ),
                  // Custom dialog styles.
                  onDismissed: () => rateMyApp.callEvent(RateMyAppEventType
                      .laterButtonPressed), // Called when the user dismissed the dialog (either by taping outside or by pressing the "back" button).
                  // contentBuilder: (context, defaultContent) => content, // This one allows you to change the default dialog content.
                  // actionsBuilder: (context) => [], // This one allows you to use your own buttons.
                );
              });
            },
            leading: Icon(FontAwesomeIcons.star),
            title: Text('Bizi Puanla'),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BioPages(
                    initialPage: count_page,
                  ),
                ),
              );
            },
            leading: Icon(FontAwesomeIcons.sun),
            title: Text('Bugün'),
          ),
          ListTile(
            onTap: () {
              Navigator.popAndPushNamed(context, 'bio_lists');
            },
            leading: Icon(FontAwesomeIcons.archive),
            title: Text('Arşiv'),
          ),
          ListTile(
            onTap: () async {
              String url = 'mailto:crdailybiography@gmail.com';
              if (await canLaunch(url)) {
                await launch(url);
              }
            },
            leading: Icon(FontAwesomeIcons.commentDots),
            title: Text('Geri Bildirim'),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, 'settings');
            },
            leading: Icon(FontAwesomeIcons.cogs),
            title: Text('Ayarlar'),
          ),
        ],
      ),
    );
  }
}
