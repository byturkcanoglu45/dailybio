import 'package:dailybio/services/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email, password, nickname;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[50],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
              child: Container(
            margin: EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  child: Text(
                    'Giriş Yap',
                    style: GoogleFonts.sourceSansPro(
                      fontSize: 25,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 12.0,
                ),
                ListTile(
                  title: Form(
                    child: TextField(
                      onChanged: (nameValue) {
                        nickname = nameValue;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Kullanıcı Adı',
                      ),
                    ),
                  ),
                  leading: Text(
                    'Adınız:',
                    style: GoogleFonts.sourceSansPro(
                      fontSize: 17,
                    ),
                  ),
                ),
                SizedBox(
                  height: 12.0,
                ),
                ListTile(
                  title: Form(
                    child: TextField(
                      onChanged: (emailValue) {
                        email = emailValue;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Email',
                      ),
                    ),
                  ),
                  leading: Text(
                    'Email: ',
                    style: GoogleFonts.sourceSansPro(
                      fontSize: 17,
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                ListTile(
                  leading: Text(
                    'Şifre:   ',
                    style: GoogleFonts.sourceSansPro(
                      fontSize: 17,
                    ),
                  ),
                  title: Form(
                    child: TextField(
                      onChanged: (passwordValue) {
                        password = passwordValue;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Şifre',
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                ListTile(
                  title: Container(
                    decoration: BoxDecoration(
                        color: Colors.blue[300],
                        borderRadius: BorderRadius.all(
                          Radius.elliptical(12, 8),
                        )),
                    child: FlatButton(
                      onPressed: () {
                        if (email != null &&
                            password != null &&
                            nickname != null) {
                          Provider.of<AuthService>(context, listen: false)
                              .logInEmail(email, password, nickname);
                          Navigator.popAndPushNamed(context, 'bios');
                        } else {
                          print('email ve passwordu boş bırakmayınız.');
                          // TODO : Create snackbar to check email and password.
                        }
                      },
                      child: Text(
                        'Giriş yap',
                        style: GoogleFonts.sourceSansPro(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 12.0,
                ),
                ListTile(
                  onTap: () {
                    Provider.of<AuthService>(context, listen: false)
                        .signInGoogle();
                    Navigator.popAndPushNamed(context, 'bios');
                  },
                  leading: Image(
                    image: NetworkImage(
                        'https://upload.wikimedia.org/wikipedia/commons/2/21/Google_-G-_Logo.svg.png'),
                  ),
                  title: Text('Google ile giriş yap'),
                ),
                SizedBox(
                  height: 12.0,
                ),
                ListTile(
                  leading: Image(
                    image: NetworkImage(
                        'https://cdn.pixabay.com/photo/2018/05/08/18/25/facebook-3383596_1280.png'),
                  ),
                  title: Text('Facebook ile giriş yap'),
                ),
                SizedBox(
                  height: 12.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 6.0),
                      alignment: Alignment.bottomRight,
                      child: MaterialButton(
                        onPressed: () {},
                        child: Text(
                          'Şifremi unuttum',
                          style: GoogleFonts.sourceSansPro(
                              fontSize: 18, color: Colors.red[800]),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 6.0),
                      alignment: Alignment.bottomRight,
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.popAndPushNamed(context, 'bios');
                        },
                        child: Text(
                          'İptal',
                          style: GoogleFonts.sourceSansPro(
                              fontSize: 18, color: Colors.red[800]),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
