import 'package:dailybio/services/firebase_auth.dart';
import 'package:dailybio/widgets/SnackBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  //Create scaffold key for only this widget.
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String email, password, second_password, nickname, errorMessage;
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
          'Kayıt Ol',
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: deviceHeight * 0.8 / 10,
                ),
                ListTile(
                  title: Form(
                    child: TextField(
                      cursorColor: Color(0xff006a71),
                      onChanged: (nameValue) {
                        nickname = nameValue;
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
                        hintText: 'Kullanıcı Adı',
                      ),
                    ),
                  ),
                  leading: Text(
                    'Adınız:',
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
                  title: Form(
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
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
                      keyboardType: TextInputType.visiblePassword,
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
                  height: 12.0,
                ),
                Container(
                  margin: EdgeInsets.only(left: 67),
                  child: ListTile(
                    title: Form(
                      child: TextField(
                        cursorColor: Color(0xff006a71),
                        keyboardType: TextInputType.visiblePassword,
                        onChanged: (passwordValue) {
                          second_password = passwordValue;
                        },
                        obscureText: isSeems,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              icon: AnimatedContainer(
                                duration: Duration(seconds: 1),
                                child: Icon(
                                  isSeems
                                      ? FontAwesomeIcons.eyeSlash
                                      : FontAwesomeIcons.eye,
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
                          hintText: 'Yeniden Şifre',
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 12.0,
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
                            second_password != null) {
                          try {
                            Provider.of<AuthService>(context, listen: false)
                                .registerEmail(email, password, nickname);
                            if (auth.currentUser != null) {
                              Navigator.popAndPushNamed(context, 'bios');
                            }
                          } catch (e) {
                            switch (e.code) {
                              case 'email-already-in-use':
                                errorMessage =
                                    "Bu emaile sahip bir hesap zaten bulunmakta!";
                                break;
                              case 'invalid-email':
                                errorMessage = 'Geçersiz email adresi';
                                break;
                              case 'weak-password':
                                errorMessage = 'Zayıf şifre';
                                break;
                              default:
                                errorMessage =
                                    "Bilinmeyen bir hata meydana geldi.";
                            }
                            snack_bar(errorMessage, _scaffoldKey);
                          }
                        } else if (password != second_password) {
                          print('Şifreler aynı değil !');
                        } else {
                          print('email ve passwordu boş bırakmayınız.');
                          // TODO : Create snackbar to check email and password.
                        }
                      },
                      child: Text(
                        'Kayıt Ol',
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
                  title: Text('Google ile kayıt ol'),
                ),
                SizedBox(
                  height: 12.0,
                ),
                ListTile(
                  leading: Image(
                    image: NetworkImage(
                        'https://cdn.pixabay.com/photo/2018/05/08/18/25/facebook-3383596_1280.png'),
                  ),
                  title: Text('Facebook ile kayıt ol'),
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
                        onPressed: () {
                          Navigator.popAndPushNamed(context, 'login');
                        },
                        child: Text(
                          'Zaten bir hesabın var mı?',
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
                          Navigator.popAndPushNamed(context, 'bios');
                        },
                        child: Text(
                          'İptal',
                          style: GoogleFonts.sourceSansPro(
                            fontSize: 18,
                            color: Color(0xffff7e67),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
