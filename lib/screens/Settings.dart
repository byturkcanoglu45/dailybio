import 'dart:io';

import 'package:dailybio/constants.dart';
import 'package:dailybio/services/DatabaseService.dart';
import 'package:dailybio/widgets/BioDrawer.dart';
import 'package:flutter/material.dart';
import 'package:dailybio/services/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  double deviceHeight;
  double deviceWidth;
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffecf4f3),
      drawer: Drawer(
        child: BioDrawer(),
      ),
      appBar: AppBar(
        backgroundColor: Color(0xffecf4f3),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Ayarlar',
          style: kGoogleFont.copyWith(color: Colors.black, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: 10),
                alignment: Alignment.topCenter,
                child: CircleAvatar(
                  backgroundColor: Color(0xff006a71),
                  radius: 50,
                  child: Image(
                    image: AssetImage('assets/profile_logo.png'),
                  ),
                ),
              ),
              loggedIn
                  ? Container(
                      margin: EdgeInsets.only(top: deviceHeight * 1.9 / 10),
                      alignment: Alignment.topCenter,
                      child: Text(
                        'Hoşgeldin ${Provider.of<AuthService>(context, listen: false).auth.currentUser.displayName ?? 'Misafir'}',
                        style: kGoogleFont.copyWith(
                          fontSize: 22,
                          color: Colors.black,
                        ),
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.only(top: deviceHeight * 1.9 / 10),
                      alignment: Alignment.topCenter,
                      child: Text(
                        'Hoşgeldin Misafir',
                        style: kGoogleFont.copyWith(
                            fontSize: 22, color: Colors.black),
                      ),
                    ),
              Container(
                width: deviceWidth * 5 / 10,
                height: deviceHeight * 1.0 / 10,
                decoration: BoxDecoration(
                  color: Color(0xffff7e67),
                  border: Border.all(color: Color(0xffff7e67)),
                ),
                margin: EdgeInsets.fromLTRB(deviceWidth * 2.5 / 10,
                    deviceHeight * 2.5 / 10, 0, deviceHeight * 1 / 10),
                alignment: Alignment.center,
                child: ListTile(
                  leading: Icon(
                    FontAwesomeIcons.star,
                    color: Colors.white,
                  ),
                  onTap: () {
                    rateMyApp.init().then((_) {
                      rateMyApp.showRateDialog(
                        context,
                        title: 'Bizi Puanla', // The dialog title.
                        message:
                            'Eğer bu uygulamayı seviyorsan, puanlamak için biraz vaktini ayırır mısın?\nDesteğin için teşekkürler!', // The dialog message.
                        rateButton:
                            'ŞİMDİ PUANLA', // The dialog "rate" button text.
                        noButton:
                            'HAYIR, TEŞEKKÜRLER', // The dialog "no" button text.
                        laterButton:
                            'BELKİ SONRA', // The dialog "later" button text.
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
                    });
                  },
                  title: Text(
                    'Bizi Puanla',
                    style: kGoogleFont.copyWith(color: Colors.white),
                  ),
                ),
              ),
              Container(
                width: deviceWidth * 5 / 10,
                height: deviceHeight * 1.0 / 10,
                decoration: BoxDecoration(
                  color: Color(0xff006a71),
                  border: Border.all(color: Colors.green),
                ),
                margin: EdgeInsets.fromLTRB(deviceWidth * 2.5 / 10,
                    deviceHeight * 3.75 / 10, 0, deviceHeight * 1 / 10),
                alignment: Alignment.center,
                child: ListTile(
                  onTap: () async {
                    String url = 'mailto:crdailybiography@gmail.com';
                    if (await canLaunch(url)) {
                      await launch(url);
                    }
                  },
                  leading: Icon(
                    FontAwesomeIcons.commentDots,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Geri Bildirim',
                    style: kGoogleFont.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.fromLTRB(0, deviceHeight * 4 / 10, 8.0, 0),
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 30,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Color(0xffff7e67),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          border: Border.all(
                            color: Color(0xffff7e67),
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            font_size = 18;
                            setState(() {});
                            DatabaseService().saveSettings();
                          },
                          child: Center(
                            child: Text(
                              'Küçük',
                              style: kGoogleFont.copyWith(
                                  color: font_size == 18
                                      ? Colors.brown
                                      : Colors.white,
                                  fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 30,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Color(0xff68b0ab),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          border: Border.all(
                            color: Color(0xff68b0ab),
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            font_size = 20;
                            setState(() {});
                            DatabaseService().saveSettings();
                          },
                          child: Center(
                              child: Text(
                            'Orta',
                            style: kGoogleFont.copyWith(
                                color: font_size == 20
                                    ? Colors.brown
                                    : Colors.white,
                                fontSize: 16),
                          )),
                        ),
                      ),
                      Container(
                        height: 30,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Color(0xff006a71),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          border: Border.all(
                            color: Color(0xff006a71),
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            font_size = 23;
                            setState(() {});
                            DatabaseService().saveSettings();
                          },
                          child: Center(
                              child: Text(
                            'Büyük',
                            style: kGoogleFont.copyWith(
                                color: font_size == 23
                                    ? Colors.brown
                                    : Colors.white,
                                fontSize: 16),
                          )),
                        ),
                      ),
                    ],
                  ),
                  leading: Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Text(
                      'Yazı Boyutu :',
                      style: kGoogleFont.copyWith(fontSize: 20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
