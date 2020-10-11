import 'package:dailybio/services/firebase_auth.dart';
import 'package:dailybio/widgets/SnackBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String email, password, nickname;
  String errorMessage;
  double deviceHeight;
  bool isSeems = false;
  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color(0xffff7e67),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color(0xffecf4f3),
        title: Text(
          'Giriş Yap',
          style: GoogleFonts.sourceSansPro(
            fontSize: 25,
            color: Color(0xffff7e67),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Color(0xffecf4f3),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            margin: EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: deviceHeight * 1.5 / 10,
                ),
                ListTile(
                  title: Form(
                    child: TextField(
                      cursorColor: Color(0xff006a71),
                      onChanged: (emailValue) {
                        email = emailValue;
                      },
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xff006a71),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xff006a71),
                          ),
                        ),
                        hintText: 'Email',
                      ),
                    ),
                  ),
                  leading: Text(
                    'Email: ',
                    style: GoogleFonts.sourceSansPro(
                      fontSize: 17,
                      color: Color(0xffff7e67),
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
                      color: Color(0xffff7e67),
                    ),
                  ),
                  title: Form(
                    child: TextField(
                      cursorColor: Color(0xff006a71),
                      onChanged: (passwordValue) {
                        password = passwordValue;
                      },
                      obscureText: !isSeems,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            icon: AnimatedContainer(
                              duration: Duration(seconds: 1),
                              child: Icon(
                                isSeems
                                    ? FontAwesomeIcons.eye
                                    : FontAwesomeIcons.eyeSlash,
                                color: Color(0xff006a71),
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                isSeems = !isSeems;
                              });
                            }),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xff006a71),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xff006a71),
                          ),
                        ),
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
                      onPressed: () async {
                        if (email != null && password != null) {
                          try {
                            await Provider.of<AuthService>(context,
                                    listen: false)
                                .logInEmail(email, password);
                          } catch (e) {
                            switch (e.code) {
                              case 'invalid-email':
                                errorMessage =
                                    "Yanlış veya geçersiz email adresi girdiniz";
                                break;
                              case 'user-not-found':
                                errorMessage = 'Kullanıcı Bulunamadı';
                                break;
                              case 'wrong-password':
                                errorMessage = 'Yanlış şifre';
                                break;
                              case 'user-disabled':
                                errorMessage = 'Email geçerli değil';
                                break;
                              default:
                                errorMessage =
                                    "Bilinmeyen bir hata meydana geldi.";
                            }
                            snack_bar(errorMessage, _scaffoldKey);
                            if (loggedIn) {
                              Navigator.popAndPushNamed(context, 'bios');
                            }
                          }
                        } else {
                          print('email ve passwordu boş bırakmayınız.');
                          // TODO : Create snackbar to check email and password.
                        }
                      },
                      child: Text(
                        'Giriş yap',
                        style: GoogleFonts.sourceSansPro(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 12.0,
                ),
                /*
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
                ), */
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
                            fontSize: 18,
                            color: Color(0xffff7e67),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 6.0),
                      alignment: Alignment.bottomRight,
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.popAndPushNamed(context, 'register');
                        },
                        child: Text(
                          'Kayıt ol',
                          style: GoogleFonts.sourceSansPro(
                            fontSize: 18,
                            color: Color(0xffff7e67),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
