import 'package:dailybio/screens/bio_pages.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dailybio/screens/bio_pages.dart';
import 'package:dailybio/services/firebase_auth.dart';
import 'package:provider/provider.dart';

class BioDrawer extends StatefulWidget {
  @override
  _BioDrawerState createState() => _BioDrawerState();
}

class _BioDrawerState extends State<BioDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          DrawerHeader(
            child: ListView(
              children: [
                CircleAvatar(
                  radius: 45,
                  backgroundColor: Color(0xFF94D6F7),
                  child: Image(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/profile_logo.png'),
                  ),
                ),
                loggedIn
                    ? ListView(
                        children: [
                          ListTile(
                            leading: Icon(FontAwesomeIcons.signInAlt),
                            title: Text(
                                'Hoşgeldin ${Provider.of<AuthService>(context, listen: false).user.nickname}'),
                          ),
                          ListTile(
                            onTap: () {
                              Provider.of<AuthService>(context, listen: false)
                                  .logOut();

                              setState(() {});
                            },
                            leading: Icon(FontAwesomeIcons.signInAlt),
                            title: Text('Çıkış yap'),
                          ),
                        ],
                      )
                    : ListTile(
                        onTap: () {
                          Navigator.popAndPushNamed(context, 'login');
                        },
                        leading: Icon(FontAwesomeIcons.signInAlt),
                        title: Text('Giriş yap veya kayıt ol'),
                      ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.star),
            title: Text('Bizi Puanla'),
          ),
          ListTile(
            onTap: () {
              pageController.jumpToPage(count_page);
              Navigator.pop(context);
            },
            leading: Icon(FontAwesomeIcons.sun),
            title: Text('Bugün'),
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.archive),
            title: Text('Arşiv'),
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.commentDots),
            title: Text('Geri Bildirim'),
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.cogs),
            title: Text('Ayarlar'),
          ),
        ],
      ),
    );
  }
}
